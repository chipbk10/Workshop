//
//  BankAccountActor.swift
//  Workshop
//
//  Created by Hieu Luong on 16/08/2022.
//

import Foundation

actor BankAccountActor {
    
    let accountName: String
    var balance: Int
    
    init(accountName: String, balance: Int) {
        self.accountName = accountName
        self.balance = balance
    }
       
    // approach5: actor
    func transfer(amount: Int, toAccount: BankAccountActor) async throws {
        
        guard balance >= amount else {
            throw BankAccountError.insufficientBalance
        }
        
        let processTime = Double.random(in: 0...2)
        Thread.sleep(forTimeInterval: processTime)
        
        balance -= amount
        await toAccount.deposit(amount: amount)
    }
    
    func deposit(amount: Int) {
        balance += amount
    }
}

enum BankAccountError: Error {
    case insufficientBalance
}
