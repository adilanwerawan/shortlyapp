//
//  InputLinkViewModelTests.swift
//  shortlyappTests
//
//  Created by MacBook on 20/05/2022.
//

import XCTest
import Combine
@testable import shortlyapp

final class InputLinkViewModelTests: XCTestCase {
    private var subject:InputLinkViewModel!
    private var cancellables:Set<AnyCancellable> = []
    private var mockShortenURLService:MockShortenURLService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockShortenURLService = MockShortenURLService()
        subject = InputLinkViewModel(shortenURLService: mockShortenURLService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        cancellables.forEach{$0.cancel()}
        cancellables.removeAll()
        mockShortenURLService = nil
        subject = nil
        
        super.tearDown()
    }
    
    func test_enteredURL_shouldCallServuce(){
        // when
        subject.getShorten(url: Constants.sampleArgumentOriginalUrl)
        
        //then
        XCTAssertEqual(mockShortenURLService.callsCount, 1)
        XCTAssertEqual(mockShortenURLService.arguments.first, Constants.sampleArgumentOriginalUrl)
    }
    
    func test_getShortenUrl_givenServiceCallSuceeds_shouldUpdateResponceModel(){
        //given
        mockShortenURLService.getResult = .success(Constants.shortUrlModel)
        
        // when
        subject.getShorten(url: Constants.sampleArgumentOriginalUrl)
        
        //then
        XCTAssertEqual(mockShortenURLService.callsCount, 1)
        XCTAssertEqual(mockShortenURLService.arguments.last, Constants.sampleArgumentOriginalUrl)
        
        XCTAssertEqual(subject.shortenURLModel, Constants.shortUrlModel)
        
        subject.$state
            .sink(receiveValue: {XCTAssertEqual($0, .finishLoading)})
            .store(in: &cancellables)
    }
    
    func test_getShortenUrl_givenServiceCallFails_shouldUpdateStateWithError(){
        // given
        mockShortenURLService.getResult = .failure(MockError.error)
        
        // when
        subject.getShorten(url: Constants.sampleArgumentOriginalUrl)
        
        // then
        XCTAssertEqual(mockShortenURLService.callsCount, 1)
        XCTAssertEqual(mockShortenURLService.arguments.last, Constants.sampleArgumentOriginalUrl)
        
        XCTAssertTrue(subject.shortenURLModel?.result == nil)
        subject.$state
            .sink(receiveValue: {XCTAssertEqual($0, .error("Failed to shorten the Url"))})
            .store(in: &cancellables)
    }
}

extension InputLinkViewModelTests{
    enum Constants{
        static let shortUrlModel = ShortenURLRoot(ok: true, result: ShortenURLResult(fullShortLink: "http://sample.shot", originalLink: "http://www.google.com"))
        static let sampleArgumentOriginalUrl = "http://www.google.com"
    }
}
