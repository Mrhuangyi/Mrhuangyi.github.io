---
title: 234. Palindrome Linked List
date: 2018-06-08 16:44:58
tags: LeetCode
categories: 题解集
---


Given a singly linked list, determine if it is a palindrome.

Example 1:

Input: 1->2
Output: false
Example 2:

Input: 1->2->2->1
Output: true
Follow up:
Could you do it in O(n) time and O(1) space?

题目要求就是给定一个单链表，让你判断是不是回文链表，最好时间复杂度控制在O(n),空间复杂度控制在O(1)

思路：
第一步：两个指针都从头出发，快指针每次两步，慢指针每次一步，这样快指针的下一个或下下个为空时，慢指针就在链表正中间那个节点了（如果链表有偶数个节点则在靠近头那侧的）。
第二步：从慢指针的下一个开始，把后面的链表都反转（Reverse Linked List），
第三步：然后我们再从头和从尾同时向中间前进，就可以判断该链表是不是回文了。
```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    bool isPalindrome(ListNode* head) {
        if(head==NULL||head->next==NULL){
            return true;
        }
        ListNode* mid = findMid(head);
        mid->next = reverse(mid->next);
        mid = mid->next;
        while(head!=NULL&&mid!=NULL){
            if(head->val!=mid->val){
                return false;
            }
            head = head->next;
            mid = mid->next;
        }
        return true;
    }
    ListNode* findMid(ListNode* now){
        ListNode* slow = now;
        ListNode* fast = now->next;
        while(fast!=NULL&&fast->next!=NULL){
            slow = slow->next;
            fast = fast->next->next;
        }
        return slow;
    }
    ListNode* reverse(ListNode* now){
        ListNode* pre = NULL;
        while(now!=NULL){
            ListNode* temp = now->next;
            now->next = pre;
            pre = now;
            now = temp;
        }
        return pre;
    }
};
```