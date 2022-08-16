//
//  Coordinator_Demo.swift
//  Workshop
//
//  Created by Hieu Luong on 09/08/2022.
//

import Foundation
import UIKit

final class Coordinator_Demo {
    
    func openPage(completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "www.google.com") else {
            completion(false)
            return
        }
                                
        if UIApplication.shared.canOpenURL(url) { // singleton
            
            UIApplication.shared.open(url, options: [:]) { canOpen in
                completion(canOpen)
            }
        } else {
            completion(false)
        }
    }
}

protocol UrlOpening {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: UrlOpening {}

final class Improved_Coordinator_Demo {
    
    private let urlOpener: UrlOpening
    init(urlOpener: UrlOpening = UIApplication.shared) {
        self.urlOpener = urlOpener
    }
    
    func openPage(completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "www.google.com") else {
            completion(false)
            return
        }
        
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:]) { canOpen in
                completion(canOpen)
            }
        } else {
            completion(false)
        }                                                
    }
}

