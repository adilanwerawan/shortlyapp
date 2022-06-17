//
//  ShortenURLService.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import Combine

protocol ShortenURLProtocol{
    func getShortenURL(originalURL:String) -> AnyPublisher<ShortenURLRoot, Error>
}

// MARK: ShortenTheLinkService has been implemented
// Purpose: Calling the api for shortening the link
final class ShortenTheLinkService:ShortenURLProtocol{
    /// Using the class Future publisher  of Combine framework which will be returning
    /// either the result with parsed model or the error
    /// getShortenURL function will take the origincal url as parameter and will return the shorten url or error
    func getShortenURL(originalURL: String) -> AnyPublisher<ShortenURLRoot, Error> {
        
        var sessionDataTask:URLSessionDataTask?
        
        let onSubscription:(Subscription) -> Void = {_ in sessionDataTask?.resume()}
        let onCancel:() -> Void = {sessionDataTask?.cancel()}
        
        // promise type is Result<ShortenURLRoot, Error>
        return Future<ShortenURLRoot, Error> { [weak self] promise in
            
            guard let shortenURLRequest = self?.getURLRequest(originalURL: originalURL) else {
                promise(.failure(ApiServiceError.urlRequest))
                return
            }
            
            sessionDataTask = URLSession.shared.dataTask(with: shortenURLRequest) { (data, _, error) in
                
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    // MARK: I have tried using Codable models but suddenly parsing getting failed
                    /* MARK: Important note
                     After trying couple of things when i have spent much time and tried parsing through Codable, i have implemented manual parsing json which we can enhance later on.
                     */
                    if let json = try JSONSerialization.jsonObject(with: data, options:.fragmentsAllowed) as? [String:Any]{
                        if let ok = json["ok"] as? Bool, ok == true, let result = json["result"] as? [String:String]{
                            var shortenUrlResult = ShortenURLResult(fullShortLink: result["full_short_link"])
                            shortenUrlResult.originalLink = result["original_link"]
                            let shortenURLRoot = ShortenURLRoot(ok: ok, result: shortenUrlResult)
                            promise(.success(shortenURLRoot))
                        }
                        else {
                            promise(.failure(ApiServiceError.decode("Shotening this url is not allowed.")))
                        }
                    } else {
                        promise(.failure(ApiServiceError.decode("Decoding failed")))
                    }
                } catch {
                    promise(.failure(ApiServiceError.decode("Decoding failed")))
                }
            }
        }
        .handleEvents(receiveSubscription:onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getURLRequest(originalURL:String) -> URLRequest?{
        guard var urlComponents = URLComponents(string: ApiConfig.BaseURLs.productionBaseURL + ApiConfig.EndPoints.shortenURL) else{
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "url", value: originalURL)
        ]
        
        guard let url = urlComponents.url else {return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 40.0
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
}
