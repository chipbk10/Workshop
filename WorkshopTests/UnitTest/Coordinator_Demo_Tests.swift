//
//  Coordinator_Demo_Tests.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 09/08/2022.
//

import XCTest
@testable import Workshop

class Coordinator_Demo_Tests: XCTestCase {

    func test_openPage_givenInvalidUrl_shouldNotOpen() {
        
        // assign
        let mockUrlOpener = MockUrlOpener(canOpen: false)
        let coordinator = Improved_Coordinator_Demo(urlOpener: mockUrlOpener)
        
        // act
        var actualCanOpen: Bool = false
        let expectation = expectation(description: "open url expectation")
        coordinator.openPage { canOpen in
            actualCanOpen = canOpen
            expectation.fulfill()
        }
                
        // assert
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(actualCanOpen)
    }

}

class MockUrlOpener: UrlOpening {
    
    private let canOpen: Bool
    init(canOpen: Bool) {
        self.canOpen = canOpen
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?) {
        completionHandler?(canOpen)
    }
}



