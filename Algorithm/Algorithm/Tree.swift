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
    
    // MARK: - 二叉树最小深度
    /// https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var depth = 0
        var queue = [root]
        while !queue.isEmpty {
            depth += 1
            let size = queue.count
            for _ in 0 ..< size {
                let t = queue.first!
                if t.left == nil && t.right == nil { return depth }
                if t.left != nil {
                    queue.append(t.left!)
                }
                if t.right != nil {
                    queue.append(t.right!)
                }
                queue.remove(at: 0)
            }
        }
        return depth
    }
    
    // MARK: 路径总和
    /// https://leetcode-cn.com/problems/path-sum/
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        var sum = sum
        sum -= root.val
        if root.left == nil && root.right == nil {
            return sum == 0
        } else {
            return hasPathSum(root.left, sum) || hasPathSum(root.right, sum)
        }
    }
    
    // MARK: 将有序数组转换为二叉搜索树
    /// https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree/
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return sortedArrayToBSTHelper(nums, 0, nums.count-1)
    }
    func sortedArrayToBSTHelper(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right { return nil }
        if left == right { return TreeNode(nums[left]) }
        let mid = (left + right)/2
        let root = TreeNode(nums[mid])
        root.left = sortedArrayToBSTHelper(nums, 0, mid-1)
        root.right = sortedArrayToBSTHelper(nums, mid+1, right)
        return root
    }
    
    // MARK: 二叉树的所有路径
    /// https://leetcode-cn.com/problems/binary-tree-paths/
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var res = [String]()
        binaryTreePathsHelper(root, "", &res)
        return res
    }
    func binaryTreePathsHelper(_ root: TreeNode?, _ str: String, _ res: inout [String]) {
        guard let root = root else {
            return
        }
        var str = str
        str = str + "\(root.val)"
        if root.left == nil && root.right == nil {
            res.append(str)
        } else {
            binaryTreePathsHelper(root.left, str + "->", &res)
            binaryTreePathsHelper(root.right, str + "->", &res)
        }
    }
    
    // MARK: 验证二叉搜索树
    /// https://leetcode-cn.com/problems/validate-binary-search-tree/
    func isValidBST(_ root: TreeNode?) -> Bool {
        return bstHelper(root, Int.min, Int.max)
    }
    func bstHelper(_ root: TreeNode?, _ min: Int, _ max: Int) -> Bool {
        guard let root = root else { return true }
        if root.val >= max || root.val <= min { return false }
        return bstHelper(root.left, min, root.val) && bstHelper(root.right, root.val, max)
    }
    
    // MARK: 从前序与中序遍历序列构造二叉树
    /// https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        /*
        if inorder.count == 0 {
            return nil
        }
        let root = TreeNode(preorder[0])
        let rootIdx = inorder.firstIndex(of: preorder[0])!
        let leftCount = rootIdx
        
        let leftPre = Array(preorder[1 ..< 1+leftCount])
        let leftInorder = Array(inorder[0 ..< rootIdx])
        
        let rightPre = Array(preorder[1+leftCount ..< preorder.count])
        let rightInorder = Array(inorder[rootIdx+1 ..< inorder.count])
        
        root.left = buildTree(leftPre, leftInorder)
        root.right = buildTree(rightPre, rightInorder)
        
        return root
         */
        
        //解法2
        _preorder = preorder
        _inorder = inorder
        var idx = 0;
        for v in inorder {
            _valMap[v] = idx
            idx += 1
        }
        return buildTreeHelper(0, inorder.count)
    }
    var _preIdx: Int = 0
    var _preorder: [Int] = []
    var _inorder: [Int] = []
    var _valMap: [Int: Int] = [Int: Int]()
    func buildTreeHelper(_ left: Int, _ right: Int) -> TreeNode? {
        if left == right {
            return nil
        }
        
        let rootVal = _preorder[_preIdx]
        _preIdx += 1
        
        let root = TreeNode(rootVal)
        let mid = _valMap[rootVal]
        root.left = buildTreeHelper(left, mid!)
        root.right = buildTreeHelper(mid!+1, right)
        
        return root
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
