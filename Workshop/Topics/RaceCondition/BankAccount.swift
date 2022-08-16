//
//  BankAccount.swift
//  Workshop
//
//  Created by Hieu Luong on 16/08/2022.
//

import Foundation

struct BankAccount {
    
    let accountName: String
    var balance: Int
       
    // approach5: actor
    
    
    /*
    // approach4: semaphore
    // Value here represents the number of concurrent threads can have access to particular section of code
    private let semaphore = DispatchSemaphore(value:1)
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        
        semaphore.wait()
        
        guard balance >= amount else {
            return false
        }
        
        let processTime = Double.random(in: 0...2)
        Thread.sleep(forTimeInterval: processTime)
        
        balance -= amount
        toAccount.balance += amount
        
        semaphore.signal()
        
        return true
    }
     */
     
     
    /*
    // approach3: concurrent queue with dispatch barrier
    private let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        
        concurrentQueue.sync(flags: .barrier) {
            guard balance >= amount else {
                return false
            }
            
            let processTime = Double.random(in: 0...2)
            Thread.sleep(forTimeInterval: processTime)
            
            balance -= amount
            toAccount.balance += amount
            
            return true
        }
    }
     */
    
    /*
    // approach2: serial queue
    private let seriaQueue = DispatchQueue(label: "SerialQueue")
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        
        seriaQueue.sync {
            guard balance >= amount else {
                return false
            }
            
            let processTime = Double.random(in: 0...2)
            Thread.sleep(forTimeInterval: processTime)
            
            balance -= amount
            toAccount.balance += amount
            
            return true
        }
    }
     */
    
    /*
    let semaphore = DispatchSemaphore(value: 1)
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        semaphore.wait()
        
        
        guard balance >= amount else {
            return false
        }
        
        let processTime = Double.random(in: 0...2)
        Thread.sleep(forTimeInterval: processTime)
        
        balance -= amount
        toAccount.balance += amount
        
        semaphore.signal()
        
        return true
    }
    */
     
    /*
    // approach1: using Lock
    private let lock = NSLock()
    
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        
        lock.lock() // block all other threads to access this critial session
        
        guard balance >= amount else {
            return false
        }
        
        let processTime = Double.random(in: 0...2)
        Thread.sleep(forTimeInterval: processTime)
        
        balance -= amount
        toAccount.balance += amount
        
        lock.unlock() // release
        
        return true
    }
    */
            
    @discardableResult
    mutating func transfer(amount: Int, toAccount: inout BankAccount) -> Bool {
        
        // step1: guarantee we have sufficient balance to transfer
        guard balance >= amount else {
            return false
        }
        
        // step2: we need sometime to process
        // prepare data,
        // fetch data from database
        // need to check some conditions before performing actual transaction
        let processTime = Double.random(in: 0...2)
        Thread.sleep(forTimeInterval: processTime)
        
        // step3: perform actual transaction
        // update the balance
        balance -= amount
        toAccount.balance += amount
        
        return true
    }
}
