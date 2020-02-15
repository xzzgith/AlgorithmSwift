//
//  Tree.swift
//  Algorithm
//
//  Created by 谢志振 on 2020/2/12.
//  Copyright © 2020 aihuishou. All rights reserved.
//

import UIKit


// Definition for a binary tree node.
public class TreeNode {
 public var val: Int
 public var left: TreeNode?
 public var right: TreeNode?
 public init(_ val: Int) {
     self.val = val
     self.left = nil
     self.right = nil
 }
}


class Tree: NSObject {
    /// 后序遍历
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        helper_p(root, &res)
        
        
//        guard let root = root else { return res }
//        var stack = Stack<TreeNode>()
//        var t = root
//        while t.left != nil || t.right != nil {
//            if let r = t.right {
//                stack.push(r)
//            }
//            if let l = t.left {
//                stack.push(l)
//            }
//            t = stack.peek()!
//        }
//        while !stack.isEmpty() {
//            let node = stack.pop()!
//            res.append(node.val)
//        }
//
        return res
    }
    func helper_p(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        helper_p(node.left, &res)
        helper_p(node.right, &res)
        res.append(node.val)
    }
    
    
    /// 中序
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        helper_in(root, &res)
        return res
    }
    func helper_in(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        helper_in(node.left, &res)
        res.append(node.val)
        helper_in(node.right, &res)
    }
    
    /// 先序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        //递归
//        helper(root, &res)
        //迭代
        guard let root = root else { return res }
        var stack = Stack<TreeNode>()
        stack.push(root)
        while !stack.isEmpty() {
            let t = stack.pop()!
            res.append(t.val)
            if let r = t.right {
                stack.push(r)
            }
            if let l = t.left {
                stack.push(l)
            }
        }
        return res
    }
    func helper(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        res.append(node.val)
        helper(node.left, &res)
        helper(node.right, &res)
    }
    
    
    
    /// https://leetcode-cn.com/problems/same-tree/
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p?.val == q?.val && q != nil && p != nil {
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        } else {
            return false
        }
    }
    
    /// 对称二叉树
    /// https://leetcode-cn.com/problems/symmetric-tree/
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        return isSy(root.left, root.right)
    }
    func isSy(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        if left == nil || right == nil {
            return false
        }
        if left!.val == right!.val {
            return isSy(left?.left, right?.right) && isSy(left?.right, right?.left)
        } else {
            return false
        }
    }
}

struct Stack<T> {
    private var elements = [T]()
    
    init() {}
    
    mutating func pop() -> T? {
        return self.elements.popLast()
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    func peek() -> T? {
        return self.elements.last
    }
    
    func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    
}
