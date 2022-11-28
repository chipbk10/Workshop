//
//  CircleView.swift
//  SampleApp
//
//  Created by Hieu Luong on 21/11/2022.
//

import UIKit
import Combine

class CircleView: UIView {
    
    var subscriptions: Set<CircleViewSubscription> = Set()
        
    init(borderColor: UIColor = .blue, backgroundColor: UIColor = .white, borderWidth: CGFloat = 2.0) {                
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = layer.bounds.width / 2
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
