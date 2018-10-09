---
title: 1096 Consecutive Factors (20)（20 分）
date: 2018-07-31 15:29:51
tags: PAT
categories: 题解集
---

Among all the factors of a positive integer N, there may exist several consecutive numbers. For example, 630 can be factored as 3*5*6*7, where 5, 6, and 7 are the three consecutive numbers. Now given any positive N, you are supposed to find the maximum number of consecutive factors, and list the smallest sequence of the consecutive factors.

Input Specification:

Each input file contains one test case, which gives the integer N (1<N<2^31^).

Output Specification:

For each test case, print in the first line the maximum number of consecutive factors. Then in the second line, print the smallest sequence of the consecutive factors in the format "factor[1]*factor[2]*...*factor[k]", where the factors are listed in increasing order, and 1 is NOT included.

Sample Input:
```
630
```
Sample Output:
```
3
5*6*7
```
题目大意：
给出一个正整数n，求一段连续的整数，使n能被这段连续整数的乘积整除，如果有多个方案，输出连续整数个数最多的方案；如果还有多种方案，输出第一个数最小的方案。
步骤：
1 由于n不会被除自己以外的大于根号n的整数整除，所以只需从2~根号n遍历连续整数的第一个，求此时n能被最多多少个连续整数的乘积整除，同时记录对应连续整数的第一个数和最多个数
2 如果遍历结束最长长度为0，那么答案就是n本身，否则输出相应结果。

```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
#include<cstring>
using namespace std;
typedef long long LL;
int main() {
    LL n;
    scanf("%lld", &n);
    LL sqr = (LL)sqrt(1.0 * n), first = 0, maxLen = 0;
    for(LL i = 2; i <= sqr; i++) {
        LL temp = 1, j = i;
        while(1) {
            temp *= j;
            if(n % temp != 0) {
                break;
            }
            if(j - i + 1 > maxLen) {
                first = i;
                maxLen = j - i + 1;
            }
            j++;
        }
    }
    if(maxLen == 0) {
        printf("1\n%lld", n);
    } else {
        printf("%lld\n", maxLen);
        for(LL i = 0; i < maxLen; i++) {
            printf("%lld", first + i);
            if(i < maxLen - 1) {
                printf("*");
            }
        }
    }
    return 0;
}

```