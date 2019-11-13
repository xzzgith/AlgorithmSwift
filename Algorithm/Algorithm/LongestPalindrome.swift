//
//  LongestPalindrome.swift
//  Algorithm
//
//  Created by Felix on 2019/11/13.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit

class LongestPalindrome: NSObject {
    func longestPalindrome(_ s: String) -> String {
        if s.count == 0 { return "" }
        var start = 0, end = 0, maxLen = 0
        for i in 0 ..< s.count {
            let len = expand(s, i, i)
            let lens = expand(s, i, i+1)
            maxLen = max(max(len, lens), maxLen)
            if maxLen > end - start + 1 {
                start = i - (maxLen - 1) / 2
                end = i + maxLen / 2
            }
        }
        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(s.startIndex, offsetBy: end)
        let subStr = s[startIndex...endIndex]
        return String(subStr)
    }
    
    func expand(_ s: String, _ l: Int, _ r: Int) -> Int {
        var l = l, r = r
        let chars: [Character] = Array(s)
        while l>=0 && r<s.count && chars[l]==chars[r] {
            l -= 1
            r += 1
        }
        return r - l - 1
    }
    
}
