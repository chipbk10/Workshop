//
//  TDD_Demo.swift
//  Workshop
//
//  Created by Hieu Luong on 02/08/2022.
//

final class TDD_Demo {
    
    
    func convert(_ s: String) -> Int? {
        
        guard !s.isEmpty else { return nil }
        
        let cs = Array(s)
        guard cs[0].isNumber || cs[0] == "-" || cs[0] == "+" else {
            return nil
        }
        
        
        // "42"
        var result = 0
        let sign = cs[0] == "-" ? -1 : 1
        
        var index = cs[0].isNumber ? 0 : 1
        
        while index < cs.endIndex {
            
            result *= 10
            result += cs[index].toNumber()
            
            index += 1
        }
        
        return sign * result
    }
    
}
