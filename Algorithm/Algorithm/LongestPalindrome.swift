//
//  LongestPalindrome.swift
//  Algorithm
//
//  Created by Felix on 2019/11/13.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit

class LongestPalindrome: NSObject {
    /// 中心扩散
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
    
    /// 动态规划
    func longestPalindrome2(_ s: String) -> String {
        if s.count < 1 { return "" }
        let len = s.count
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: len), count: len)
        var longestPalindrome = 1
        var longestPalindromeStr = String(s.prefix(1))
        let chars: [Character] = Array(s)
        for r in 1 ..< len {
            for l in 0 ..< r {
                if chars[l]==chars[r] && (r-l<=2 || dp[l+1][r-1]) {
                    dp[l][r] = true
                    if r-l+1 > longestPalindrome {
                        longestPalindrome = r-l+1
                        let startIndex = s.index(s.startIndex, offsetBy: l)
                        let endIndex = s.index(s.startIndex, offsetBy: r)
                        longestPalindromeStr = String(s[startIndex...endIndex])
                    }
                }
            }
        }
        return longestPalindromeStr
    }
}
