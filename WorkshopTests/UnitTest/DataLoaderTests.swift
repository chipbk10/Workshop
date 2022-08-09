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
        let dataLoader = ImprovedDataLoader(bundle: mockBundle)
        let fileName = "mockFileName"
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: fileName)) { error in
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
        let dataLoader = ImprovedDataLoader(bundle: mockBundle)
        let fileName = "NonExistingFile"
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: fileName)) { error in
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
        let dataLoader = ImprovedDataLoader(bundle: mockBundle)
        let fileName = "Empty.json"
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: fileName)) { error in
            if let actualError = error as? DataLoaderError {
                XCTAssertEqual(actualError, .invalidJson)
            } else {
                XCTFail("wrong error")
            }
        }
    }
    
    func test_load_givenInvalidJsonFile_shouldReturnInvalidDataError() {
        // assign
        let mockBundle = Bundle(for: type(of: self))
        let dataLoader = ImprovedDataLoader(bundle: mockBundle)
        let fileName = "Invalid.json"
        
        // act
        XCTAssertThrowsError(try dataLoader.load(fileName: fileName)) { error in
            if let actualError = error as? DataLoaderError {
                XCTAssertEqual(actualError, .invalidJson)
            } else {
                XCTFail("wrong error")
            }
        }
    }
    
    func test_load_givenValidJsonFile_shouldReturnValidData() {
        // assign
        let mockBundle = Bundle(for: type(of: self))
        let dataLoader = ImprovedDataLoader(bundle: mockBundle)
        let fileName = "Valid.json"
        
        // act
        guard let actualData = try? dataLoader.load(fileName: fileName) else {
            XCTFail("expect to receive data, but get error")
            return
        }
                
        XCTAssertTrue(!actualData.isEmpty)
        XCTAssertEqual(actualData[0].name, "John")
    }

}

class MockBundle: Bundle {
    
    private let isValidUrl: Bool
    
    init(isValidUrl: Bool) {
        self.isValidUrl = isValidUrl
        super.init()
    }
    
    override func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return isValidUrl ? URL(string: "validUrl") : nil
    }
}
