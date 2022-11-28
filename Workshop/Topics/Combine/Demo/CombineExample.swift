//
//  CombineExample.swift
//  SampleApp
//
//  Created by Hieu Luong on 22/11/2022.
//

class CombineExample {
    
    func run() {
//         runSequencePublisher()
        runOurOwnPublisher()
    }
        
    private func runSequencePublisher() {
        
        let publisher = (0...6).publisher
        
        _ = publisher.sink { _ in
            print("Receive: completion")
        } receiveValue: { num in
            print("Receive: \(num)")
        }
    }
    
    private func runOurOwnPublisher() {
        
        let subscriberA = IntSubscriber(name: "A", demandValue: 2)
        let subscriberB = IntSubscriber(name: "B", demandValue: 4)
        let publisher = IntPublisher()

        publisher.receive(subscriber: subscriberA)
        publisher.receive(subscriber: subscriberB)
        
        
        publisher.send(1)
        publisher.send(completion: .finished)
        
        publisher.send(2)
        publisher.send(3)
        publisher.send(4)
        publisher.send(5)
        publisher.send(6)
        // publisher.send(completion: .finished)
    }
}
