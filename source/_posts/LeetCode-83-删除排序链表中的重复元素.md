---
title: LeetCode 83. 删除排序链表中的重复元素
date: 2018-05-18 12:18:37
tags: LeetCode
categories: 题解集
---
给定一个排序链表，删除所有重复的元素，使得每个元素只出现一次。

示例 1:

输入: 1->1->2
输出: 1->2
示例 2:

输入: 1->1->2->3->3
输出: 1->2->3

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */

```cpp
class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        if(!head){
            return head;
        }//真正写的时候，链表为空一定不能漏了
        int val = head->val;
        ListNode* p = head;
        while(p&&p->next){
            if(p->next->val!=val){
                val = p->next->val;
                p = p->next;
            }else{
                ListNode* n = p->next->next;
                p->next = n;
            }
        }
        return head;
    }
};
```