//
//  ViewController+CircleView.swift
//  SampleApp
//
//  Created by Hieu Luong on 22/11/2022.
//

import UIKit

extension ViewController {
    
    func addALoopCircleViews(coords: [(CGFloat, CGFloat)]) -> CircleView? {
        var prev: CircleView?
        var firstCircleView: CircleView?
        
        for coord in coords {
            let cur = addCircleView(coord: coord)
            if let prev = prev {
                prev.receive(subscriber: cur)
            }
            if prev == nil { firstCircleView = cur }
            prev = cur
        }
        if let firstCircleView = firstCircleView {
            prev?.receive(subscriber: firstCircleView)
        }
        return firstCircleView
    }
    
    fileprivate func addCircleView(size: CGFloat = 50, coord: (CGFloat, CGFloat)) -> CircleView {
        let (x,y) = coord
        let v = CircleView()
        v.frame = CGRect(x: x, y: y, width: size, height: size)
        view.addSubview(v)
        return v
    }
}
