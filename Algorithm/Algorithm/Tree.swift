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
    
    /// 对称二叉树 也可以用队列进行迭代
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
    
    // MARK: - 最大深度
    /// https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
    func maxDepth(_ root: TreeNode?) -> Int {
//        guard let root = root else {
//            return 0
//        }
//        return max(maxDepth(root.left), maxDepth(root.right)) + 1
        guard let root = root else {
            return 0
        }
        var queue: [TreeNode] = [root]
        var num = 0
        while !queue.isEmpty {
            let n = queue.count
            for _ in 0 ..< n {
                let temp = queue.first!
                if temp.left != nil {
                    queue.append(temp.left!)
                }
                if temp.right != nil {
                    queue.append(temp.right!)
                }
                queue.remove(at: 0)
            }
            num += 1
        }
        return num
    }
    
    // MARK: - 翻转二叉树
    /// https://leetcode-cn.com/problems/invert-binary-tree/
    func invertTree(_ root: TreeNode?) -> TreeNode? {
//        guard let root = root else {
//            return nil
//        }
//        let left = invertTree(root.left)
//        let right = invertTree(root.right)
//        root.left = right
//        root.right = left
//        return root
        guard let root = root else {
            return nil
        }
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            let node = queue.first
            queue.remove(at: 0)
            let t = node?.left
            node?.left = node?.right
            node?.right = t
            if node?.left != nil { queue.append(node!.left!) }
            if node?.right != nil { queue.append(node!.right!) }
        }
        return root
    }

    // MARK: - 层次遍历
    /// https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var queue = [root]
        var ans = [[Int]]()
        while !queue.isEmpty {
            let size = queue.count
            var tArr = [Int]()
            for _ in 0 ..< size {
                let t = queue.first!
                tArr.append(t.val)
                if t.left != nil {
                    queue.append(t.left!)
                }
                if t.right != nil {
                    queue.append(t.right!)
                }
                queue.remove(at: 0)
            }
            ans.insert(tArr, at: 0)
            //ans.append(tArr)
        }
        return ans
    }
    // MARK: - 平衡二叉树
    /*
     平衡二叉树 这道题思想是
     1.当前节点 的左孩子 和右孩子的高度不超过1
     2.左孩子是平衡的
     3.又孩子是平衡的
     */
    /// https://leetcode-cn.com/problems/balanced-binary-tree/
    func isBalanced(_ root: TreeNode?) -> Bool {
        return depth(root) != -1
    }
    func depth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        let left = depth(root.left)
        if left == -1 { return -1 }
        let right = depth(root.right)
        if right == -1 { return -1 }
        return abs(left-right) < 2 ? max(depth(root.left), depth(root.right)) + 1 : -1
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
