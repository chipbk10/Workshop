//
//  CombineExample+Implement.swift
//  SampleApp
//
//  Created by Hieu Luong on 22/11/2022.
//

import Combine

class IntSubscriber: Subscriber {
    
    typealias Input = Int
    typealias Failure = Never
    
    private let demandValue: Int
    private let name: String
    
    init(name: String, demandValue: Int) {
        self.name = name
        self.demandValue = demandValue
    }
    
    func receive(subscription: Subscription) {
        print("Subscriber \(name) received subscription")
        subscription.request(.max(demandValue))  // 5 --> we want to 5 times only
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("Subscriber \(name) received \(input)")
        return .none // I don't want to modify the original demand (5) --> .max(1) --> (6)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Subscriber \(name) received completion: \(completion)")
    }
}

class IntPublisher: Combine.Subject {
        
    typealias Output = Int
    typealias Failure = Never
            
    private var subscriptions: Set<IntSubscription> = Set()
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        let subscription = IntSubscription(subscriber: subscriber, publisher: self)
        subscriptions.insert(subscription)
        subscriber.receive(subscription: subscription) // send it back
    }
    
    func send(_ value: Int) {
        subscriptions.forEach {
            $0.send(value) // no send to subscriber
        }
    }
    
    func send(completion: Subscribers.Completion<Never>) {
        subscriptions.forEach {
            $0.send(completion: completion)
        }
    }
    
    func send(subscription: Subscription) {
        // modify | add the subscription in runtime (if needed)
    }
}

private extension IntPublisher {
    
    private func disassociate(_ subscriptionToRemove: IntSubscription) {
        if let index = subscriptions.firstIndex(of: subscriptionToRemove) {
            subscriptions.remove(at: index)
        }
    }
    
    private class IntSubscription: Subscription, Equatable, Hashable {
        
        private var demand: Subscribers.Demand = .none
        private var subscriber: (any Subscriber<Int,Never>)?
        private var publisher: IntPublisher?
        
        init<S>(subscriber: S, publisher: IntPublisher) where S : Subscriber, Never == S.Failure, Int == S.Input {
            self.subscriber = subscriber
            self.publisher = publisher
        }
        
        func request(_ demand: Subscribers.Demand) {
            self.demand = demand
        }
        
        func cancel() {
            demand = .none
            subscriber = nil
            publisher?.disassociate(self)
        }
        
        func send(_ value: Int) {
            guard demand > 0, let subscriber = subscriber else { return }
            demand -= 1
            demand += subscriber.receive(value)
        }
        
        func send(completion: Subscribers.Completion<Never>) {
            subscriber?.receive(completion: completion)
            cancel()
        }
                        
        // conform to Equatable and Hashable to put into a Set
        
        internal static func == (lhs: IntSubscription,
                                 rhs: IntSubscription) -> Bool {
            return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
        }
        
        internal func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }
    }
    
}
