//
//  Roman2Integer.swift
//  Algorithm
//
//  Created by 谢志振 on 2020/2/11.
//  Copyright © 2020 aihuishou. All rights reserved.
//  https://leetcode-cn.com/problems/roman-to-integer/

import UIKit

class Roman2Integer: NSObject {
    func mapRoman(_ s: Character) -> Int {
        switch s {
        case "I": return 1
        case "V": return 5
        case "X": return 10
        case "L": return 50
        case "C": return 100
        case "D": return 500
        case "M": return 1000
        default: return 0
        }
    }
    func romanToInt(_ s: String) -> Int {
        var result = 0
        
        for i in 0..<s.count  {
            
            let cur = s[s.index(s.startIndex, offsetBy: i)]
            let curInt = mapRoman(cur)
            
            if i+1 == s.count {
                result += curInt
            } else {
                let right = s[s.index(s.startIndex, offsetBy: i+1)]
                let rightInt = mapRoman(right)
                if curInt >= rightInt {
                    result += curInt
                } else {
                    result -= curInt
                }
            }
        }
        return result
    }
}
