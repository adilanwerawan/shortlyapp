//
//  MockInputUrlService.swift
//  shortlyappTests
//
//  Created by MacBook on 20/05/2022.
//

import Foundation
import Combine
@testable import shortlyapp

final class MockShortenURLService : ShortenURLProtocol{
    
    var arguments:[String?] = []
    var callsCount:Int = 0
    
    var getResult:Result<ShortenURLRoot, Error> = .success(ShortenURLRoot())
    
    func getShortenURL(originalURL: String) -> AnyPublisher<ShortenURLRoot, Error> {
        arguments.append(originalURL)
        callsCount += 1
        return getResult.publisher.eraseToAnyPublisher()
    }
}
