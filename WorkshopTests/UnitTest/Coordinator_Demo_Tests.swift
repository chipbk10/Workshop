//
//  Coordinator_Demo_Tests.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 09/08/2022.
//

import XCTest
@testable import Workshop

class Coordinator_Demo_Tests: XCTestCase {

    func test_givenInvalidUrl_shouldNotOpen() {
        
        // assign
        let mockUrlOpener = MockUrlOpener(canOpen: false)
        let coordintaor = Improved_Coordinator_Demo(urlOpener: mockUrlOpener)
        
        // act
        var actualCanOpen: Bool = false
        let expectation = expectation(description: "OpenUrl expectation")
        coordintaor.openPage { canOpen in
            actualCanOpen = canOpen
            expectation.fulfill()
        }
                                
        // assert
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(actualCanOpen)
    }
    
    func test_givenValidUrl_shouldOpen() {
        
        // assign
        let mockUrlOpener = MockUrlOpener(canOpen: true)
        let coordintaor = Improved_Coordinator_Demo(urlOpener: mockUrlOpener)
        
        // act
        var actualCanOpen: Bool = false
        let expectation = expectation(description: "OpenUrl expectation")
        coordintaor.openPage { canOpen in
            actualCanOpen = canOpen
            expectation.fulfill()
        }
                                
        // assert
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(actualCanOpen)
    }

}

final class MockUrlOpener: URLOpening {
    
    private let canOpen: Bool
    init(canOpen: Bool) {
        self.canOpen = canOpen
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        canOpen
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        completion?(canOpen)
    }
}


