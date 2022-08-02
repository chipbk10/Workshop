//
//  TDD_Demo_Test.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 02/08/2022.
//

import XCTest
@testable import Workshop

class TDD_Demo_Test: XCTestCase {

    // s = "0" -> 0
    func test_convert_givenZeroString_shouldReturnZero() {
        
        // assign
        let s = "0"
        let demo = TDD_Demo()
        
        // act
        let actualResult = demo.convert(s)
        
        // assertion
        XCTAssertEqual(actualResult, 0)
    }
    
    // s = "" -> nil
    func test_convert_givenEmptyString_shouldReturnNil() {
        
        // assign
        let s = ""
        let demo = TDD_Demo()
        
        // act
        let actualResult = demo.convert(s)
        
        // assertion
        XCTAssertNil(actualResult)
    }
    
    // s = "42" -> 42
    func test_convert_givenValidPositiveNumberString_shouldReturnValidPositiveNumber() {
        
        // assign
        let s = "42"
        let demo = TDD_Demo()
        
        // act
        let actualResult = demo.convert(s)
        
        // assertion
        XCTAssertEqual(actualResult, 42)
    }
    
    // s = "-42" -> -42
    func test_convert_givenValidNegativeNumberString_shouldReturnValidNegativeNumber() {
        
        // assign
        let s = "-42"
        let demo = TDD_Demo()
        
        // act
        let actualResult = demo.convert(s)
        
        // assertion
        XCTAssertEqual(actualResult, -42)
    }
    
    // s = "+42" -> 42
    func test_convert_givenValidPositiveNumberStringWithSign_shouldReturnValidPositiveNumber() {
        
        // assign
        let s = "+42"
        let demo = TDD_Demo()
        
        // act
        let actualResult = demo.convert(s)
        
        // assertion
        XCTAssertEqual(actualResult, 42)
    }
    
    // s = "442abdfsdfsd58" -> nil
    // s = "234323243242343242342342342342342342342332423423" -> overflow -> nil
    // s = "-23432894932794798237497239749723479237497329479237497239" -> underflow -> nil
    
    // finish all the test case -> implementqion is done
}
