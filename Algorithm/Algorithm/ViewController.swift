//
//  ViewController.swift
//  Algorithm
//
//  Created by Felix on 2019/10/17.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
class Solution {
    /// 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
    /// 输出：7 -> 0 -> 8
    /// 原因：342 + 465 = 807
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry = 0,l1 = l1,l2 = l2
        let head = ListNode(0)
        var node = head
        while l1 != nil || l2 != nil || carry != 0 {
            if l1 != nil {
                carry += l1!.val
                l1 = l1!.next
            }
            if l2 != nil {
                carry += l2!.val
                l2 = l2!.next
            }
            node.next = ListNode(carry%10)
            node = node.next!
            carry = carry / 10
        }
        return head.next
    }
    
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count == 1 { return 1 }
        var map = [Character: Int]()
        var left = 0
        var maxLength = 0
        for (i,char) in s.enumerated() {
            if map.keys.contains(char) { left = max(left, map[char]!) }
            map[char] = i+1
            maxLength = max(maxLength, i-left+1)
        }
        return maxLength
    }
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var node1 = ListNode(1)
        var node2 = ListNode(2)
        var node3 = ListNode(3)
        var node4 = ListNode(4)
        var node5 = ListNode(5)
        node1.next = node2
        node2.next = node3
//        node3.next = node4
//        node4.next = node5
        let ss = LinkedList().reverseList2(node1)
        
        let re = DynamicProgramming().coinChange2([1,2,5], 11)
        let d = DynamicProgramming().climbStairs(91)
//        var a = [1,6,3,9,4]
//        print("\(bubble(&a))")
//        print("\(quick(&a))")
        
//        dfs(1)//从第一个盒子开始
//        dfs2(1)
//        print("总共有\(total/2)种")
        
        
        //走过的路标记为1 障碍为1
//        book2[0][0] = 1
//        dfs3(x: 0, y: 0, step: 0)
//        print("找到小B最短路径为\(min)步")
        
//        Bfs().find()
//        var result =  twoSum([4, 4, 2,6,11, 15], 8)
//        print("result = \(result)")
        
//        if isPalindrome(0) {
//            print("回文")
//        } else {
//            print("不是回文")
//        }
        
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var m = [Int: Int]()
        for (i, value) in nums.enumerated() {
            if let a = m[target - value] {
                if target - value != value { return [i,a] }
            }
            m[value] = i
        }
        return []
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        let str = String(x)
        if str.count==1 { return false }
        var a = [Character]()
        var s = Array<Character>(repeating: "s", count: 10)
        for c in str {
            a.append(c)
            print("\(c)")
        }
        var top = 0
        let mid = str.count/2 - 1
        for i in 0...mid {
            top += 1
            s[top] = a[i]
        }
        var next = 0
        if str.count%2==0 {
            next = mid + 1
        } else {
            next = mid + 2
        }
        for i in next..<str.count {
            if a[i] != s[top] { break }
            top -= 1
        }
        return top == 0
    }
    func bubble(_ list: inout [Int]) -> [Int] {
        for i in 0..<list.count-1 {
            for j in 0..<list.count-1-i {
                if list[j] > list[j+1] {
                    let tmp = list[j]
                    list[j] = list[j+1]
                    list[j+1] = tmp
                }
            }
        }
        return list
    }
    
    func quick(_ list: inout [Int]) -> [Int] {
        if list.count <= 1 {
            return list
        } else {
            let pivot = list.popLast()!
            var greater: [Int] = []
            var lesser: [Int] = []
            
            for element in list {
                if element > pivot {
                    greater.append(element)
                } else {
                    lesser.append(element)
                }
            }
            return quick(&lesser) + [pivot] + quick(&greater)
        }
    }
    
    private lazy var a: [Int] = {
        var a = Array(repeating: 0, count: 10)
        return a
    }()
    private lazy var book: [Int] = {
        var book = Array(repeating: 0, count: 10)
        return book
    }()
    let n = 3//1-9
    
    /*
       dfs基本模型
       判断边界
       尝试每一种可能 for {
       继续下一步 dfs(step+1)
       }
       返回
    */
    func dfs(_ step: Int) -> Void {
        if step == n+1 {
            for i in 1...n {
                print("\(a[i])")
            }
            print("---------")
            return
        }
        for i in 1...n {
            if book[i] == 0 {
                a[step] = i//第i张牌放到第step个盒子里
                book[i] = 1
                dfs(step+1)
                book[i] = 0
            }
        }
    }
    // [][][] + [][][] = [][][]
    // 空格里为1-9 有多少种可能
    var m: Int = 9
    var total: Int = 0
    func dfs2(_ step: Int) -> Void {
        if step == 10 {
            if a[1]*100 + a[2]*10 + a[3] + a[4]*100 + a[5]*10 + a[6] == a[7]*100 + a[8]*10 + a[9] {
                total += 1
                print("\(a[1]*100 + a[2]*10 + a[3])+\(a[4]*100 + a[5]*10 + a[6])=\(a[7]*100 + a[8]*10 + a[9])")
            }
        }
        for i in 1...m {
            if book[i] == 0 {
                a[step] = i//第i张牌放到第step个盒子里
                book[i] = 1
                dfs2(step+1)
                book[i] = 0
            }
        }
    }
    
    // MARK: -
    // MARK: 迷宫找人
    /// 小A在(0,0) 小B在(p,q)
    /// 求在m迷宫中找到小B的最短路径
    let p = 3
    let q = 2
    var min = 999999
    private lazy var maze: [[Int]] = {
        var maze = [
            [0,0,1,0],
            [0,0,0,0],
            [0,0,1,0],
            [0,1,0,0],
            [0,0,0,1]
        ]
        return maze
    }()
    private lazy var book2: [[Int]] = {
        var book2 = [
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0]
        ]
        return book2
    }()
    func dfs3(x: Int, y: Int, step: Int) {
        //走的方向右下左上
        let next: [[Int]] = [
            [0,1],
            [1,0],
            [0,-1],
            [-1,0]
        ]
        if x == p && y == q {
            if step < min { min = step }
            return
        }
        for n in next {
            let nx = x + n[0]
            let ny = y + n[1]
            //判断越界
            if nx < 0 || ny < 0 || nx > 4 || ny > 3 { continue }
            if maze[nx][ny] == 0 && book2[nx][ny] == 0 {
                book2[nx][ny] = 1
                dfs3(x: nx, y: ny, step: step+1)
                book2[nx][ny] = 0
            }
        }
    }
    
}

