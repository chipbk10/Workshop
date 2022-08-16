//
//  DataLoaderTests.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 09/08/2022.
//

import XCTest
@testable import Workshop

class DataLoaderTests: XCTestCase {

    func test_load_givenInvalidFileName_shouldReturnInvalidUrlError() {
        
        // assign
        let mockBundle = MockBundle(isValidUrl: false)
        let dataLoader = ImprovedDataLoader(bundle:mockBundle)
        
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: "whatever")) { error in
            if let actualError = error as? DataLoaderError {
                XCTAssertEqual(actualError, .invalidUrl)
            } else {
                XCTFail("wrong error")
            }
        }
    }
    
    func test_load_givenInvalidFileName_shouldReturnInvalidUrlError_improved() {
        
        // assign
        let mockBundle = Bundle(for: type(of: self))
        let dataLoader = ImprovedDataLoader(bundle:mockBundle)
        
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: "NonExistingFile")) { error in
            if let actualError = error as? DataLoaderError {
                XCTAssertEqual(actualError, .invalidUrl)
            } else {
                XCTFail("wrong error")
            }
        }
    }
    
    func test_load_givenEmptyFile_shouldReturnInvalidDataError() {
        
        // assign
        let mockBundle = Bundle(for: type(of: self))
        let dataLoader = ImprovedDataLoader(bundle:mockBundle)
        
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: "Empty.json")) { error in
            if let actualError = error as? DataLoaderError {
                XCTAssertEqual(actualError, .invalidJson)
            } else {
                XCTFail("wrong error")
            }
        }
    }
    

}

class MockBundle: Bundle {
    
    private let isValidUrl: Bool
    
    init(isValidUrl: Bool) {
        self.isValidUrl = isValidUrl
        super.init()
    }
    
    override func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return isValidUrl ? URL(string: "ValidUrl") : nil
    }
}
