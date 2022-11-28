//
//  UIView+Animation.swift
//  SampleApp
//
//  Created by Hieu Luong on 22/11/2022.
//

import UIKit

extension UIView {
    
    func move(to destination: CGPoint, duration: TimeInterval,
              options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.center = destination
        }, completion: nil)
    }
    
}

