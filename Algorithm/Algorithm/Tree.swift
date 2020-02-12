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
    
    /// 先序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        //递归
        helper(root, &res)
        //迭代
//        guard let root = root else { return res }
//        var stack = Stack<TreeNode>()
//        stack.push(root)
//        while !stack.isEmpty() {
//            let t = stack.pop()!
//            res.append(t.val)
//            if let r = t.right {
//                stack.push(r)
//            }
//            if let l = t.left {
//                stack.push(l)
//            }
//        }
        return res
    }
    func helper(_ node: TreeNode?, _ res: inout [Int]) {
        guard let node = node else { return }
        res.append(node.val)
        helper(node.left, &res)
        helper(node.right, &res)
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
    
    func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    
}
