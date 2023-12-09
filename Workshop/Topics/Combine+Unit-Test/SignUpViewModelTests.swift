//
//  SignUpViewModelTests.swift
//  DemoCombineTests
//
//  Created by Luong, D.H. (Dinh Hieu) on 23/11/2023.
//

import Combine
import XCTest
@testable import DemoCombine

final class SignUpViewModelTests: XCTestCase {
    
    private var cancellable = Set<AnyCancellable>()
    
    func testUserEmailValid() {
        
        // assign
        let viewModel = SignUpViewModel()
        var error: Error?
        var isEmailValid: Bool?
        let expectation = expectation(description: "should finish")
                
        viewModel.isUserEmailValidPublisher
            .dropFirst() // because we don't care the first value (an empty string)
            .sink(receiveCompletion: { completion in // subsciber
                switch completion {
                case .finished:
                    break
                case .failure(let actualError):
                    error = actualError
                }
                expectation.fulfill()
            }, receiveValue: { isValid in
                isEmailValid = isValid
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        // act
        viewModel.userEmail = "Test@gmail.com"
        
        // assert
        waitForExpectations(timeout: 10)
        cancellable.forEach { $0.cancel() }
        XCTAssertNil(error)
        XCTAssertEqual(isEmailValid, true)
    }
    
    func testPasswordValid() {
        
        // assign
        let viewModel = SignUpViewModel()
        var error: Error?
        var isPasswordValid: Bool?
        let expectation = expectation(description: "should finish")
        viewModel.isPasswordValidPublisher
            .dropFirst()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let actualError):
                    error = actualError
                }
                expectation.fulfill()
            }, receiveValue: { isValid in
                isPasswordValid = isValid
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        // act
        viewModel.userPassword = "12345678"
        
        // assert
        waitForExpectations(timeout: 10)
        cancellable.forEach { $0.cancel() }
        XCTAssertNil(error)
        XCTAssertEqual(isPasswordValid, true)
    }
    
    /*
    func testUserEmailValid_better() {
        let viewModel = SignUpViewModel()
        let (values, error) = awaitPublisher(viewModel.isUserEmailValidPublisher) {
            viewModel.userEmail = "hieu@gmail.com"
        }
        XCTAssertNil(error)
        XCTAssertEqual(values.last, true)
    }
    
    func testUserEmailValid_better_2() {
        let viewModel = SignUpViewModel()
        let (values, error) = awaitPublisher(viewModel.isUserEmailValidPublisher, count: 2) {
            viewModel.userEmail = "hieu@gmail.com"
            viewModel.userEmail = "hieu" // invalid email
        }
        XCTAssertNil(error)
        XCTAssertEqual(values.dropFirst(), [true, false])
    }
    */
}

extension XCTestCase {
    
    // apply for any publisher
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        count: Int = 1,
        timeout: TimeInterval = 10,
        calls: @escaping () -> Void
    ) -> ([T.Output], Error?) {
        
        // assign
        var values = [T.Output]()
        var error: Error?
        var count = count
        guard count > 0 else {
            return (values, error)
        }
                
        let expectation = self.expectation(description: "Awaiting publisher")
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let actualError):
                    error = actualError
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                values.append(value)
                count -= 1
                if (count == 0) {
                    expectation.fulfill()
                }
            }
        )
        
        // act
        calls() // trigger the publisher
        
        
        // assert
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        return (values, error)
    }
}
