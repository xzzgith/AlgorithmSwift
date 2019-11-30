//
//  LinkedList.swift
//  Algorithm
//
//  Created by Felix on 2019/11/15.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit

class LinkedList: NSObject {

    /// 双指针 一次遍历
    func removeNthFromEnd2(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        var first: ListNode? = dummy, second: ListNode? = dummy
        for _ in 1...n+1 { first = first?.next }
        while first != nil {
            first = first?.next
            second = second?.next
        }
        second?.next = second?.next?.next
        return dummy.next
    }
    
    /// 两次遍历
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard let head = head else { return nil }
        var len = 0, first: ListNode? = head
        let dummy = ListNode(0)
        dummy.next = head
        while first != nil {
            len += 1
            first = first?.next
        }
        len -= n//找到待删结点的前驱元
        first = dummy
        while len > 0 {
            len -= 1
            first = first?.next
        }
        first?.next = first?.next?.next
        return dummy.next
    }
    
    // MARK: - 旋转链表
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        if head.next == nil || k == 0 { return head }
        var len = 1, k = k
        var node: ListNode?, tail: ListNode? = head
        while tail?.next != nil {
            len += 1
            tail = tail?.next
        }
        k = k % len
        if k == 0 { return head }

        len = len - k - 1
        node = head
        while len > 0 {
            len -= 1
            node = node?.next
        }
        let newHead = node?.next
        node?.next = nil
        tail?.next = head
        return newHead
    }
    
    /// 双指针
    func rotateRight2(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        if head.next == nil || k == 0 { return head }
        var len = 0, k = k
        var node: ListNode? = head
        while node != nil {
            len += 1
            node = node?.next
        }
        k = k % len
        if k == 0 {
            return head
        }
        var fast: ListNode? = head, slow: ListNode? = head
        while k > 0 {
            k -= 1
            fast = fast?.next
        }
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        let newHead = slow?.next
        slow?.next = nil
        fast?.next = head
        return newHead
    }
    // MARK: - 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = ListNode(head!.val)
        var node: ListNode? = head
        var tmp: ListNode?
        while node != nil {
            if dummy.next == nil {
                dummy.next = ListNode(node!.val)
            } else {
                tmp = ListNode(node!.val)
                tmp?.next = dummy.next
                dummy.next = tmp
            }
            node = node?.next
        }
        return dummy.next
    }
    func reverseList2(_ head: ListNode?) -> ListNode? {
        var pre: ListNode?
        var tmp: ListNode?
        var cur: ListNode? = head
        while cur != nil {
            tmp = cur?.next
            cur?.next = pre
            pre = cur
            cur = tmp
        }
        return pre
    }
    /// 递归
    func reverseList3(_ head: ListNode?) -> ListNode? {
        if head?.next == nil { return head }
        let cur = reverseList3(head?.next)
        head?.next?.next = head
        head?.next = nil
        return cur
    }
    
    /// 反转前n项
    var success: ListNode?
    func reverseN(_ head: ListNode?, _ n: Int) -> ListNode? {
        if n == 1 {
            success = head?.next
            return head
        }
        let cur = reverseN(head?.next, n-1);
        head?.next?.next = head
        head?.next = success
        return cur
    }
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        if m == 1 { return reverseN(head, n) }
        head?.next = reverseBetween(head?.next, m-1, n-1)
        return head
    }
    
}
