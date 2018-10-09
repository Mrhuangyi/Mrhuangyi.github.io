---
title: 1007 Maximum Subsequence Sum (25)（25 分）
date: 2018-08-23 16:59:26
tags: PAT
categories: 题解集
---

1007 Maximum Subsequence Sum (25)（25 分）
Given a sequence of K integers { N~1~, N~2~, ..., N~K~ }. A continuous subsequence is defined to be { N~i~, N~i+1~, ..., N~j~ } where 1 <= i <= j <= K. The Maximum Subsequence is the continuous subsequence which has the largest sum of its elements. For example, given sequence { -2, 11, -4, 13, -5, -2 }, its maximum subsequence is { 11, -4, 13 } with the largest sum being 20.

Now you are supposed to find the largest sum, together with the first and the last numbers of the maximum subsequence.

Input Specification:

Each input file contains one test case. Each case occupies two lines. The first line contains a positive integer K (<= 10000). The second line contains K numbers, separated by a space.

Output Specification:

For each test case, output in one line the largest sum, together with the first and the last numbers of the maximum subsequence. The numbers must be separated by one space, but there must be no extra space at the end of a line. In case that the maximum subsequence is not unique, output the one with the smallest indices i and j (as shown by the sample case). If all the K numbers are negative, then its maximum sum is defined to be 0, and you are supposed to output the first and the last numbers of the whole sequence.

Sample Input:
```
 10
 -10 1 2 3 4 -5 -23 3 7 -21
```
Sample Output:
```
10 1 4

```
求解最大连续子序列和，并且要求输出首尾元素，
边界dp[0] = a[0]
转移方程：if(dp[i - 1] + a[i]) > a[i] : dp[i] = dp[i - 1] + a[i]
                 else  dp[i] = a[i]
用s[i]表示以a[i]作为结尾的最大连续子序列是从哪个元素开始的
两种情况
1 只有一个元素，这个最大连续子序列就是从a[i]开始，s[i] = a[i]
2 s[i] = s[i - 1]


```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<vector>
#include<cstring>
#include<algorithm>
using namespace std;
const int maxn = 10010;
int a[maxn], dp[maxn];
int s[maxn] = {0};
int main() {
    int n;
    scanf("%d", &n);
    bool flag = false;
    for(int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
        if(a[i] >= 0) {
            flag = true;
        }
    }
    if(flag == false) {
        printf("0 %d %d\n", a[0], a[n - 1]);
        return 0;
    }
    dp[0] = a[0];
    for(int i = 1; i <= n; i++) {
        if(dp[i - 1] + a[i] > a[i]) {
            dp[i] = dp[i - 1] + a[i];
            s[i] = s[i - 1];
        } else {
            dp[i] = a[i];
            s[i] = i;
        }
    }
    int k = 0;
    for(int i = 1; i < n; i++) {
        if(dp[i] > dp[k]) {
            k = i;
        }
    }
    printf("%d %d %d\n", dp[k], a[s[k]], a[k]);
    return 0;
}

```