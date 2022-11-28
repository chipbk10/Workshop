//
//  ViewController.swift
//  SampleApp
//
//  Created by Hieu Luong on 21/11/2022.
//

import UIKit
import Combine

let DURATION: TimeInterval = 1
let SHOULDMOVE: Bool = true

class ViewController: UIViewController {
    
//    private var coords: [(CGFloat, CGFloat)] = [(250, 250), (500, 250)] // two views
    private var coords: [(CGFloat, CGFloat)] = [(250,250), (375, 150), (500, 250), (375,350)] // many views
    
    var firstCircleView: CircleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        run()
    }
    
    func run() {
        if let firstCircleView = addALoopCircleViews(coords: coords) {
            let color = UIColor.red
            let pos = firstCircleView.frame.origin
            firstCircleView.send((color, pos))
        }
    }
}


