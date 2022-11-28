//
//  CircleView+Publisher.swift
//  SampleApp
//
//  Created by Hieu Luong on 21/11/2022.
//

import Combine
import UIKit

extension CircleView: Subject {
    
    typealias Output = (UIColor, CGPoint)
    typealias Failure = Never
        
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, (UIColor, CGPoint) == S.Input {
        let subscription = CircleViewSubscription(subscriber: subscriber, publisher: self)
        subscriptions.insert(subscription)
        subscriber.receive(subscription: subscription)
    }
    
    func send(_ value: (UIColor, CGPoint)) {
        backgroundColor = .white
        subscriptions.forEach {
            $0.send(value)            
        }        
    }
    
    func send(completion: Subscribers.Completion<Never>) {
        subscriptions.forEach {
            $0.send(completion: completion)
        }
    }
    
    func send(subscription: Subscription) {
        // todo
    }
}
