//
//  ShortenLinksListingViewModel.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation
import CoreData
import Combine

// MARK: ShortenLinksListingViewModel has been implemented
/// Purpose: Performing the necessary presentation logics work usng the Combine and Retrieving the data from CoreData
final class ShortenLinksListingViewModel{
    
    enum Section{ case shortenUrls }
    
    @Published var savedLinksArray = [SavedLink]()
    @Published var state:InputLinkViewModelState = .finishLoading
    @Published var enteredURL = ""
    
    var context:NSManagedObjectContext
    var shortenURLModel:ShortenURLRoot? = nil{
        didSet{
            if let model = shortenURLModel{
                saveToDatabaseWith(model: model)
            }
        }
    }
    
    private(set) lazy var isURLValid = $enteredURL.map{$0.lowercased().validateUrl()}.eraseToAnyPublisher()
    private let shortenLinkService:ShortenURLProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(context:NSManagedObjectContext = CoreDataStack.shared.workingContext, shortenURLService:ShortenURLProtocol = ShortenTheLinkService()){
        self.context = context
        self.shortenLinkService = shortenURLService
        fetchDatabaseObjects()
    }
    
    func navigationTitle() -> String{
        return "Your Link History"
    }
    
    func fetchDatabaseObjects(){
        savedLinksArray.removeAll()
        guard let objects = HistoryShortenUrls.fetchShortenUrls(context: self.context) else {
            return
        }
        let sortedArray = objects.reversed()
        for obj in sortedArray{
            let savedLink = SavedLink(fullShortLink: obj.shortenUrl, originalLink: obj.originalUrl)
            savedLinksArray.append(savedLink)
        }
    }
    
    func shortenURL(){
        getShorten(url: enteredURL)
    }
    
    func saveToDatabaseWith(model:ShortenURLRoot){
        self.context.perform { [unowned self] in
            let obj = HistoryShortenUrls(context: self.context)
            obj.originalUrl = model.result?.originalLink
            obj.shortenUrl = model.result?.fullShortLink
            CoreDataStack.shared.saveWorkingContext(context: self.context)
            fetchDatabaseObjects()
        }
    }
}

extension ShortenLinksListingViewModel{
    private func getShorten(url:String){
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
