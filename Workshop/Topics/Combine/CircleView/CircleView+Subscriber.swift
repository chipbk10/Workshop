//
//  CircleView+Subscriber.swift
//  SampleApp
//
//  Created by Hieu Luong on 21/11/2022.
//

import Combine
import UIKit

extension CircleView: Subscriber {
                            
    typealias Input = (UIColor, CGPoint)
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: (UIColor, CGPoint)) -> Subscribers.Demand {
        
        let (color, pos) = input
        backgroundColor = color
        
        let originalPos = self.frame.origin
        
        // send back
        DispatchQueue.main.asyncAfter(deadline: .now() + DURATION/4) { [weak self] in
            guard let self = self else { return }
            self.send(
                (color, originalPos)
            )
        }
        
        
        if SHOULDMOVE && (pos.x != originalPos.x || pos.y != originalPos.y) {
            // move
            DispatchQueue.main.async { [weak self] in
                self?.move(to: pos, duration: DURATION, options: .transitionCurlDown)
            }
        }
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        backgroundColor = .white
    }
}

