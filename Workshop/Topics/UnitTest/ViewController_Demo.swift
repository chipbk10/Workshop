//
//  Delegate_Demo.swift
//  Workshop
//
//  Created by Hieu Luong on 09/08/2022.
//

import Foundation

final class ViewController_Demo {
    weak var delegate: SomeDelegate?
    
    // ...
}

protocol SomeDelegate: AnyObject {
    // ....
}
