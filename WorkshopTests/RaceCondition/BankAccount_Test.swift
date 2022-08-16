//
//  BankAccount_Test.swift
//  WorkshopTests
//
//  Created by Hieu Luong on 16/08/2022.
//

import XCTest
@testable import Workshop

class BankAccount_Test: XCTestCase {

    func test_transfer_given2TransactionsAtTheSameTime_shouldNotTransferMoreThanBalance() {
    
        // assign
        var accountA = BankAccount(accountName: "A", balance: 100)
        var accountB = BankAccount(accountName: "B", balance: 0)
        
        let concurrentQueue1 = DispatchQueue(label: "ConcurrentQueue1", attributes: .concurrent)
        let concurrentQueue2 = DispatchQueue(label: "ConcurrentQueue2", attributes: .concurrent)
        
        // act
        let expectation1 = expectation(description: "expect to finish transaction1")
        let expectation2 = expectation(description: "expect to finish transaction2")
        
        var transaction1: Bool?
        var transaction2: Bool?
        
        concurrentQueue1.async {
            transaction1 = accountA.transfer(amount: 50, toAccount: &accountB)
            expectation1.fulfill()
        }
        
        concurrentQueue2.async {
            transaction2 = accountA.transfer(amount: 70, toAccount: &accountB)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 5)
        
        // assign
        print("accountA.balance = \(accountA.balance)")
        print("accountB.balance = \(accountB.balance)")
        
        print("transaction1 = \(String(describing: transaction1))")
        print("transaction2 = \(String(describing: transaction2))")
        
        XCTAssertTrue(accountA.balance >= 0, "AccountA's balance = \(accountA.balance)")
        XCTAssertTrue(accountB.balance >= 0, "AccountB's balance = \(accountB.balance)")
    }

}
