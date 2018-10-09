---
title: 532. 数组中的K-diff数对
date: 2018-06-27 20:34:28
tags: LeetCode
categories: 题解集
---

给定一个整数数组和一个整数 k, 你需要在数组里找到不同的 k-diff 数对。这里将 k-diff 数对定义为一个整数对 (i, j), 其中 i 和 j 都是数组中的数字，且两数之差的绝对值是 k.

示例 1:
```
输入: [3, 1, 4, 1, 5], k = 2
输出: 2
解释: 数组中有两个 2-diff 数对, (1, 3) 和 (3, 5)。
```
尽管数组中有两个1，但我们只应返回不同的数对的数量。
示例 2:
```
输入:[1, 2, 3, 4, 5], k = 1
输出: 4
解释: 数组中有四个 1-diff 数对, (1, 2), (2, 3), (3, 4) 和 (4, 5)。
```
示例 3:
```
输入: [1, 3, 1, 5, 4], k = 0
输出: 1
解释: 数组中只有一个 0-diff 数对，(1, 1)。
```
注意:

数对 (i, j) 和数对 (j, i) 被算作同一数对。
数组的长度不超过10,000。
所有输入的整数的范围在 [-1e7, 1e7]。
分析，题目要求差为k的数对有多少对，这里当k为0时，数组里某个数出现大于2都算做1个数对，当k大于0，也需要去重，所以我用了两个容器，map用来映射计数，set用来结果去重。
```cpp
class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        if(nums.size()==0||k<0){
            return 0;
        }
        map<int,int> m ;
        set<int> s;
        int count = 0;
        for(int i=0;i<nums.size();i++){
            m[nums[i]]++;
        }
        for(int i=0;i<nums.size();i++){
            if(k==0){
                {
                if(m[nums[i]]>=2){
                   s.insert(nums[i]); 
                }
                    count = s.size();
                }
            }else{
                if(m[nums[i]+k]>0){
                    s.insert(nums[i]);
                }
                count = s.size();
            }
        }
        return count;
    }
};
```