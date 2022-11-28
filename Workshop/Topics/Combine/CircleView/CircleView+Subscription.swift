//
//  CircleViewSubscription.swift
//  SampleApp
//
//  Created by Hieu Luong on 21/11/2022.
//

import Combine
import UIKit

extension CircleView {
    
    private func disassociate(_ subscriptionToRemove: CircleViewSubscription) {
        if let index = subscriptions.firstIndex(of: subscriptionToRemove) {
            subscriptions.remove(at: index)
        }
    }
    
    class CircleViewSubscription: Subscription, Equatable, Hashable {
        
        private var demand: Subscribers.Demand = .none
        private var subscriber: (any Subscriber<(UIColor, CGPoint), Never>)?
        private var publisher: CircleView?
        
        init<S>(subscriber: S, publisher: CircleView) where S : Subscriber, Never == S.Failure, (UIColor, CGPoint) == S.Input {
            self.subscriber = subscriber
            self.publisher = publisher
        }
        
        func request(_ demand: Subscribers.Demand) {
            self.demand += demand
        }
        
        func cancel() {
            demand = .none
            subscriber = nil
            publisher?.disassociate(self)
        }
        
        func send(_ value: (UIColor, CGPoint)) {
            guard demand > 0, let subscriber = subscriber else { return }
            demand -= 1
            demand += subscriber.receive(value)            
        }            
        
        func send(completion: Subscribers.Completion<Never>) {
            cancel()
        }
                
        internal static func == (lhs: CircleViewSubscription,
                                 rhs: CircleViewSubscription) -> Bool {
            return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
        }
        
        internal func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self))
        }
    }
}

