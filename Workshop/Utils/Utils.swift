//
//  Utils.swift
//  Workshop
//
//  Created by Hieu Luong on 26/07/2022.
//

extension Character {
    
    // convert a single character to a number
    // e.g., "5" -> 5, "7" -> 7
    func toNumber() -> Int {
        let zero: Character = "0"
        return Int(asciiValue!) - Int(zero.asciiValue!)
    }
}
