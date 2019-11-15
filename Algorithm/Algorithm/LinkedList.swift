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
}
