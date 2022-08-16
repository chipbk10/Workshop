//
//  ViewController_Demo_Tests.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 09/08/2022.
//

import Foundation
@testable import Workshop
import XCTest

class ViewController_Demo_Tests: XCTestCase {
    
    func test_delegate_shouldNotRetained() {
        
        // assign
        var mockDelegate = MockSomeDelegate()
        let vc = ViewController_Demo()
        vc.delegate = mockDelegate
        
        // act
        mockDelegate = MockSomeDelegate()
                
        // assert
        XCTAssertNil(vc.delegate)        
    }
}

final class MockSomeDelegate: SomeDelegate {
    // ....
}
