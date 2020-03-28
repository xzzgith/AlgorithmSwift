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
    // MARK: 搜索插入位置
    /// https://leetcode-cn.com/problems/search-insert-position/
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
//        O(n)
//        var i = 0
//        for v in nums {
//            if v >= target {
//                return i
//            }
//            i += 1
//        }
//        return nums.count
        // 二分查找
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }
    // MARK: maxSubArray
    /// https://leetcode-cn.com/problems/maximum-subarray/
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 1 { return nums[0] }
        var ans = nums[0]
        var sum = 0
        for v in nums {
            if sum > 0 {
                sum += v
            } else {
                sum = v
            }
            if ans < sum {
                ans = sum
            }
        }
        return ans
    }
    
    // MARK: plusOne
    /// https://leetcode-cn.com/problems/plus-one/
    func plusOne(_ digits: [Int]) -> [Int] {
        var needAdd = true
        var ans = [Int]()
        for v in digits.reversed() {
            var val = v
            if needAdd {
                val += 1
                if val == 10 {
                    val = 0
                    needAdd = true
                } else {
                    needAdd = false
                }
            }
            ans.insert(val, at: 0)
        }
        if needAdd { ans.insert(1, at: 0) }
        return ans
    }
    // MARK: - best-time-to-buy-and-sell-stock
    /// https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 { return 0 }
        var minPrice = prices[0]
        var maxProfit = 0
        for i in 1 ..< prices.count {
            maxProfit = max(maxProfit, prices[i] - minPrice)
            minPrice = min(minPrice, prices[i])
        }
        return maxProfit
    }
    
    // MARK: - container-with-most-water
    /// https://leetcode-cn.com/problems/container-with-most-water/
    func maxArea(_ height: [Int]) -> Int {
        var l = 0
        var r = height.count - 1
        var m = 0
        while l < r {
            m = max(m, min(height[l], height[r]) * (r-l))
            if height[l] < height[r] {
                l += 1
            } else {
                r -= 1
            }
        }
        return m
    }
    
    // MARK: - 只出现一次的数字
    /// https://leetcode-cn.com/problems/single-number/submissions/
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0
        nums.forEach { res = res ^ $0 }
        return res
    }
}
