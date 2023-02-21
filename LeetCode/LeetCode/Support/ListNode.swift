//
//  ListNode.swift
//  LeetCode
//
//  Created by Худышка К on 21.02.2023.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init() {
        self.val = 0;
        self.next = nil;
    }
    init(_ val: Int) {
        self.val = val;
        self.next = nil;
    }
    init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

extension ListNode {
    var values: [Int] {
        var values = [Int]()
        
        while next != nil {
            values.append(val)
        }
        
        return values
    }
}
