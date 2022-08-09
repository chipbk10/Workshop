//
//  DataLoader.swift
//  Workshop
//
//  Created by Hieu Luong on 09/08/2022.
//

import Foundation

final class OriginalDataLoader {
    
    static let shared = OriginalDataLoader()
    private let cache: [String:[User]] = [:]
    
    func load(fileName: String) throws -> [User] {
        
        if let cacheData = cache[fileName] {
            return cacheData
        }
        
        let bundle = Bundle.main
        
        guard let url = bundle.url(forResource: fileName, withExtension: nil) else {
            throw NSError(domain: "com.workshop.ing", code: 7, userInfo: nil)
        }
        
        let jsonData = try Data(contentsOf: url)
        let data = try JSONDecoder().decode([User].self, from: jsonData)
        return data
    }
    
}

struct User: Decodable {
    let name: String
    let age: Int
}
