---
title: LeetCode 26. 删除排序数组中的重复项
date: 2018-05-17 16:05:52
tags: LeetCode
categories: 题解集
---
给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。

**不要使用额外的数组空间**，你必须在原地修改输入数组并在使用** O(1) 额外**空间的条件下完成。

示例 1:

给定数组 nums = [1,1,2], 

函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。 

你不需要考虑数组中超出新长度后面的元素。
示例 2:

给定 nums = [0,0,1,1,1,2,2,3,3,4],

函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。

你不需要考虑数组中超出新长度后面的元素。
解法一：标记下标，然后遍历数组元素依次进行比较，出现不等元素就赋值给标记的下一个位置
解法二：利用STL里的unique函数（由于给的是有序数组，所以可以直接用）

* unique()是C++标准库函数里面的函数，其功能是去除相邻的重复元素（只保留一个），所以使用前需要对数组进行排序
* distance主要是用来求两个迭代器之间的元素个数。
```cpp
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if(nums.empty()) return 0;
        int pos = 0;
        for(int i=0;i<nums.size()-1;i++){
            if(nums[i]!=nums[i+1]){
                nums[++pos] = nums[i+1];
            }
        }
        return pos+1;
    }
};

class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        return distance(nums.begin(),unique(nums.begin(),nums.end()));
    }
};
```