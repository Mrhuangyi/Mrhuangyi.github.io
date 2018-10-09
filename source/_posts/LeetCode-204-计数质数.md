---
title: LeetCode 204. 计数质数
date: 2018-05-17 15:52:19
categories: 题解集
tags: LeetCode
---
统计所有小于非负数整数 n 的质数的数量。

示例:

输入: 10
输出: 4
解释: 小于 10 的质数一共有 4 个, 它们是 2, 3, 5, 7 。

先预处理，不是素数的就标记出来
```cpp
class Solution {
public:
    int countPrimes(int n) {
        vector<bool> isPrime(n,true);
        for(int i=2;i*i<n;i++){
            if(isPrime[i]){
                for(int j=i*i;j<n;j+=i){
                    isPrime[j] = false;
                }
            }
        }
        int cnt = 0;
        for(int i=2;i<n;i++){
            if(isPrime[i]){
                cnt++;
            }
        }
        return cnt;
    }
  
};
```