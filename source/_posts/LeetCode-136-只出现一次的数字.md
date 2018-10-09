---
title: LeetCode 136.只出现一次的数字
date: 2018-05-17 15:46:22
categories: 题解集
tags: LeetCode
---
给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

说明：

你的算法应该具有**线性时间复杂度**。 你可以**不使用额外空间**来实现吗？

示例 1:

输入: [2,2,1]
输出: 1
示例 2:

输入: [4,1,2,1,2]
输出: 4

分析，只有一个元素出现一次，其余均出现两次，可以想到异或运算符，
遍历整个数组，出现两次的异或以后为0，最后自然只剩下了出现一次的。
```cpp
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int x = 0;
        for(int i=0;i<nums.size();i++){
            x^=nums[i];
        }
        return x;
    }
};
```