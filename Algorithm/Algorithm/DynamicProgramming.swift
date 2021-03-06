//
//  DynamicProgramming.swift
//  Algorithm
//
//  Created by Felix on 2019/11/17.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit

class DynamicProgramming: NSObject {
    /*
     动态规划
     1.重叠子问题
     2.状态转移方程
     3.最优子结构：原问题的解由子问题的最优解构成。要符合「最优子结构」，子问题间必须互相独立
 */
    /// Fibonacci
    func fib(_ N: Int) -> Int {
        if N == 0 { return 0 }
        if N <= 2 { return 1 }
//        return fib(N-1) + fib(N-2)
        var fn1 = 0, fn2 = 1, result = 0
        for _ in 2 ... N {
            result = fn1 + fn2
            fn1 = fn2
            fn2 = result
        }
        return result
    }
    
    /// 零钱兑换 递归 + 备忘录
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var memo = Array(repeating: -2, count: amount+1)
        return coinChangeHelper(coins, amount, &memo)
    }
    func coinChangeHelper(_ coins: [Int], _ amount: Int, _ memo: inout [Int]) -> Int {
        if amount == 0 { return 0 }
        if memo[amount] != -2 { return memo[amount] }
        var ans = Int32.max
        for i in 0 ..< coins.count {
            if amount - coins[i] < 0 { continue }
            let subProb = coinChangeHelper(coins, amount - coins[i], &memo)
            if subProb == -1 { continue }
            ans = min(ans, Int32(subProb + 1))
        }
        memo[amount] = (ans == Int32.max) ? -1 : Int(ans)
        return memo[amount]
    }
    /// 零钱兑换 动态规划
    func coinChange2(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        var dp = Array(repeating: amount+1, count: amount+1)
        dp[0] = 0
        for i in 1 ... amount {
            for c in coins {
                if c <= i {
                    dp[i] = min(dp[i], dp[i-c] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
    /// 爬楼梯
    func climbStairs(_ n: Int) -> Int {
        if n < 3 { return n }
        var dp = Array(repeating: 0, count: n+1)
        dp[1] = 1
        dp[2] = 2
        for i in 3 ... n {
            dp[i] = dp[i-1] + dp[i-2]
        }
        return dp[n]
    }
    
    func climbStairs2(_ n: Int) -> Int {
        if n < 3 { return n }
        var f1 = 1, f2 = 2, tmp = 0
        for _ in 3 ... n {
            tmp = f1 + f2
            f1 = f2
            f2 = tmp
        }
        return tmp
    }
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.count <= 1 { return [nums] }
        var nums = nums
        nums = nums.sorted()
        let book = Array(repeating: 0, count: nums.count)
        var box = Array(repeating: 0, count: nums.count)
        var result = [[Int]]()
        
        dfs(nums, 0, book, &box, &result)
        return result
    }
    
    func dfs(_ nums: [Int], _ step: Int, _ book: [Int], _ result: inout [Int], _ box: inout [[Int]]) {
        if step == nums.count {
            print("\(result)")
            box.append(result)
            return;
        }
        var book = book
        for i in 0..<nums.count {
            let num = nums[i]
            
            if book[i] == 0 {
                if i > 0 && nums[i] == nums[i-1] && book[i-1]==0 { continue }
                result[step] = num
                book[i] = 1
                dfs(nums, step+1, book, &result, &box)
                book[i] = 0
            }
        }
    }
    //123
    func reverse(_ x: Int) -> Int {
        var isNeg = false
        var x = x, r = 0, t = 0
        if x < 0 {
            x = -x
            isNeg = true
        }
        while x > 0 {
            t = x % 10
            x = x / 10
            r = r * 10 + t
        }
        return isNeg ? -r : r
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var cur: ListNode? = dummy, l1 = l1, l2 = l2
        while l1 != nil && l2 != nil {
            if l1?.val ?? 0 < l2?.val ?? 0 {
                cur?.next = l1
                cur = cur?.next
                l1 = l1?.next
            } else {
                cur?.next = l2
                cur = cur?.next
                l2 = l2?.next
            }
        }
        cur?.next = (l1 == nil) ? l2 : l1
        return dummy.next
    }
    func mergeTwoLists2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1?.val ?? 0 < l2?.val ?? 0 {
            l1?.next = mergeTwoLists2(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists2(l1, l2?.next)
            return l2
        }
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count < 2 { return nums.count }
        var idx = 0
        for i in 1 ..< nums.count {
            if nums[i] != nums[idx] {
                idx += 1
                nums[idx] = nums[i]
            }
        }
        return idx+1
    }
}
