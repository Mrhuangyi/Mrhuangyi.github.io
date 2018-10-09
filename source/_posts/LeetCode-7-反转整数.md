---
title: LeetCode 7. 反转整数
date: 2018-05-18 12:10:35
tags: LeetCode
categories: 题解集
---
给定一个 32 位有符号整数，将整数中的数字进行反转。

示例 1:

输入: 123
输出: 321
 示例 2:

输入: -123
输出: -321
示例 3:

输入: 120
输出: 21
注意:

假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−2^31,  2^31 − 1]。根据这个假设，如果反转后的整数溢出，则返回 0。

这道题主要还是考察细节问题；
1. 考虑负数的情况
2. 考虑溢出，包括正溢出和负溢出，即如果是正数，则大于2147483647溢出；如果是负数，则小于-2147483648溢出
```cpp
class Solution {
public:
    int reverse(int x) {
        long long r = 0;
        long long t = x;
        if(t<0){
            t=-t;
        }
        for(;t;t/=10){
            r=r*10+t%10;
        }
        bool sign;
        if(x>0){
            sign = false;
        }
        else{
            sign =true;
        }
        if(r>2147483647||(sign&&r>2147483648)){
            return 0;
        }else{
            if(sign){
                return -r;
            }else{
                return r;
            }
        }
    }
};
```