//
//  AppDelegate.swift
//  Workshop
//
//  Created by Hieu Luong on 26/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        runTopicUnitTest()
        return true
    }
    
    private func runTopicUnitTest() {
        let fileName = "Users.json"
        if let users = try? OriginalDataLoader.shared.load(fileName: fileName) {
            print(users)
        }
    }
}

