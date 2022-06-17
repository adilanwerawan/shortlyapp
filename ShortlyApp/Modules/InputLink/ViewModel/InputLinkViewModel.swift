//
//  InputLinkViewModel.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import Combine

enum InputLinkViewModelError:Error, Equatable{
    case makingShortURL(String)
}

// For handling different state of view model through api calling
enum InputLinkViewModelState:Equatable{
    case loading
    case finishLoading
    case error(String)
}

// MARK: InputLinkViewModel has been implemented
/// Purpose: Containing the presentation logics needed for InputLinkViewController, using Combine to fulfil the requirements
final class InputLinkViewModel{
    @Published var enteredURL = ""
    @Published var state:InputLinkViewModelState = .finishLoading
    var shortenURLModel:ShortenURLRoot? = nil{
        didSet{
            if let model = shortenURLModel{
                saveToDatabaseWith(model: model)
            }
        }
    }
    @Published var savedToDatabase = false
    
    fileprivate let context = CoreDataStack.shared.workingContext
    
    private(set) lazy var isURLValid = $enteredURL.map{$0.lowercased().validateUrl()}.eraseToAnyPublisher()
    private let shortenLinkService:ShortenURLProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(shortenURLService:ShortenURLProtocol = ShortenTheLinkService()){
        self.shortenLinkService = shortenURLService
    }
    
    func shortenURL(){
        getShorten(url: enteredURL)
    }
    
    // After getting the data from api saving it to Coredata
    func saveToDatabaseWith(model:ShortenURLRoot){
        self.context.perform { [unowned self] in
            let obj = HistoryShortenUrls(context: self.context)
            obj.originalUrl = model.result?.originalLink
            obj.shortenUrl = model.result?.fullShortLink
            CoreDataStack.shared.saveWorkingContext(context: self.context)
            self.savedToDatabase = true
        }
    }
    
    func resetFields(){
        self.savedToDatabase = false
    }
}

extension InputLinkViewModel{
    internal func getShorten(url:String){
        state = .loading
        
        let shortenURLCompletionHandler:(Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion{
            case .failure(_):
                self?.state = .error("Failed to shorten the Url")
            case .finished:
                self?.state = .finishLoading
            }
        }
        let shortenURLValueHandler:(ShortenURLRoot) -> Void = { [weak self] shortURlModel in
            self?.shortenURLModel = shortURlModel
        }
        
        self.shortenLinkService
            .getShortenURL(originalURL: url)
            .sink(receiveCompletion: shortenURLCompletionHandler, receiveValue: shortenURLValueHandler)
            .store(in: &bindings)
    }
}
