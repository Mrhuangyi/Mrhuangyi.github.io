---
title: 1049 Counting Ones (30)（30 分）
date: 2018-07-30 21:57:10
tags: PAT
categories: 题解集
---

The task is simple: given any positive integer N, you are supposed to count the total number of 1's in the decimal form of the integers from 1 to N. For example, given N being 12, there are five 1's in 1, 10, 11, and 12.

Input Specification:

Each input file contains one test case which gives the positive N (<=2^30^).

Output Specification:

For each test case, print the number of 1's in one line.

Sample Input:
```
12
```
Sample Output:
```
5
```
题目大意：
给出一个数字n，求1~n的所有数字里面出现1的个数

分析：一个个枚举计算肯定是超时的，这是个数学问题，需要寻找规律从特殊扩展到一般。
设当前处理至第k位，那么记left为第k位的高位所表示的数，now为第k位数，right为第k位的低位表示的数，分三种情况：

- 若now == 0， ans += left * a;
- now == 1 , ans += left * a + right + 1;
- now == 2 , ans += (left + 1) * a;

```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
using namespace std;
int main() {
    int n, a = 1, ans = 0;
    int left, right, now;
    scanf("%d", &n);
    while(n / a != 0) {
        left = n / (a * 10);
        now = n / a % 10;
        right = n % a;
        if(now == 0) {
            ans += left * a;
        } else if(now == 1) {
            ans += left * a + right + 1;
        } else {
            ans += (left + 1) * a;
        }
        a *= 10;
    }
    printf("%d\n", ans);
    return 0;
}

```
