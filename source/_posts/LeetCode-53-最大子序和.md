---
title: LeetCode 53. 最大子序和
date: 2018-05-17 17:29:01
categories: 题解集
tags: LeetCode
---
给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

示例:

输入: [-2,1,-3,4,-1,2,1,-5,4],
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
进阶:

如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。

这是一道很经典的算法问题了，很多算法书在讲到dp问题的时候都是作为一个范例了

- 思路1：暴力枚举，但是太low了，复杂度达到了O(n^3)量级，所以基本可以忽略
- 思路2：先预处理，因为连续子序列和等于两个前缀和之差，时间复杂度为O(n^2)
- 思路3：动态规划解法
- 思路4：分治法

我主要就了解了这几种，还有一些其他的优化解法没怎么学过。
INT_MIN在标准头文件limits.h中定义。
```cpp
#define INT_MAX 2147483647
#define INT_MIN (-INT_MAX - 1)
```
## 动态规划解法
转移方程：**dp[i+1] = max(dp[i]+a[i+1])**
```cpp
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int result = INT_MIN,f = 0;
        for(int i=0;i<nums.size();i++){
            f = max(f + nums[i],nums[i]);
            result = max(result,f);
        }
        return result;
    }
};
```

## 预处理解法
```cpp
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        return deal(nums.begin(),nums.end());
        
    }
    private:
      template<typename T>
    static int deal(T begin,T end){
          int result,cur_min;
          const int n = distance(begin,end);
          int *sum = new int[n+1];
          sum[0] = 0;
          result = INT_MIN;
          cur_min = sum[0];
          for(int i=1;i<=n;i++){
              sum[i] = sum[i-1]+*(begin + i - 1);
          }
          for(int i=1;i<=n;i++){
              result = max(result,sum[i]-cur_min);
              cur_min = min(cur_min,sum[i]);
          }
          delete[] sum;
          return result;
      }
};
```

## 分治解法
假设数组A[left,	right]存在最大区间，mid	=	(left	+	right)	/	2，那么无非就是三中情 况：
1.	最大值在A[left,	mid	-	1]里面
 2.	最大值在A[mid	+	1,	right]里面
 3.	最大值跨过了mid，也就是我们需要计算[left,	mid	-	1]区间的最大值，以及[mid +	1,	right]的最大值，然后加上mid，三者之和就是总的最大值
 
```cpp
class Solution{
public:
    int maxSubArray(int A[],int n){
        return divide(A,0,n-1,INT_MIN);
    }
    int divide(int A[],int left,int right,int maxm){
        if(left>right){
            return INT_MIN;
        }
        int mid = left+(right-left)/2;
        int lmax = divide(A,left,mid-1,maxm);
        int rmax = divide(A,mid+1,right,maxm);
        maxm = max(maxm,lmax);
        maxm = max(maxm,rmax);
        int sum = 0;
        int mlmax = 0;
        for(int i=mid-1;i>=left;i--){
            sum+=A[i];
            mlmax = max(mlmax,sum);
        }
        sum = 0;
        int mrmax = 0;
        for(int i = mid+1;i<=right;i++){
            sum += A[i];
            mrmax = max(mrmax,sum);
        }
        maxm = max(maxm,A[mid]+mlmax+mrmax);
        return maxm;
    }
};
```
