//
//  Array.swift
//  Algorithm
//
//  Created by 谢志振 on 2020/2/28.
//  Copyright © 2020 aihuishou. All rights reserved.
//

import UIKit

class List: NSObject {
    // MARK: 三数之和
    /// https://leetcode-cn.com/problems/3sum/
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var arr = nums
        arr.sort()
        
        var l = 0, r = 0
        
        var res = [[Int]]()
        
        for (i,v) in arr.enumerated() {
            if v > 0 {
                break
            }
            if i > 0 && arr[i] == arr[i-1] {
                continue
            }
            l = i + 1
            r = arr.count - 1
            
            while l < r {
                let sum = v + arr[l] + arr[r]
                if sum == 0 {
                    res.append([arr[i], arr[l], arr[r]])
                    while l<r && arr[l] == arr[l+1] { l += 1 }
                    while l<r && arr[r] == arr[r-1] { r -= 1 }
                    l += 1
                    r -= 1
                } else if sum < 0 {
                    l += 1
                } else {
                    r -= 1
                }
            }
        }
        return res
    }
    // MARK: 移除元素
    /// https://leetcode-cn.com/problems/remove-element/
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
//        var r = nums.count - 1
//        while r >= 0 {
//            if nums[r] == val {
//                nums.remove(at: r)
//            }
//            r -= 1
//        }
//        return nums.count
        //[3, 2, 2, 3]
        var r = 0
        for v in nums {
            if v != val {
                nums[r] = v
                r += 1
            }
        }
        return r
    }
}
