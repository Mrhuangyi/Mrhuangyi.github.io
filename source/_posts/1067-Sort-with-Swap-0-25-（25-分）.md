---
title: '1067 Sort with Swap(0,*) (25)（25 分）'
date: 2018-07-29 16:09:02
tags: PAT
categories: 题解集
---

Given any permutation of the numbers {0, 1, 2,..., N-1}, it is easy to sort them in increasing order. But what if Swap(0, *) is the ONLY operation that is allowed to use? For example, to sort {4, 0, 2, 1, 3} we may apply the swap operations in the following way:

Swap(0, 1) => {4, 1, 2, 0, 3}\ Swap(0, 3) => {4, 1, 2, 3, 0}\ Swap(0, 4) => {0, 1, 2, 3, 4}

Now you are asked to find the minimum number of swaps need to sort the given permutation of the first N nonnegative integers.

Input Specification:

Each input file contains one test case, which gives a positive N (<=10^5^) followed by a permutation sequence of {0, 1, ..., N-1}. All the numbers in a line are separated by a space.

Output Specification:

For each case, simply print in a line the minimum number of swaps need to sort the given permutation.

Sample Input:
```
10 3 5 7 2 6 4 9 0 8 1
```
Sample Output:
```
9
```
题目大意：给出一个0~n-1的序列，要求通过两两交换的方式将其变为递增序列，且只能是0与其他数字交换，求最小交换次数

贪心策略：
如果0在本位上就先寻找一个当前不在本位上的数字与0交换，只要0不在本位，就将0所在位置的数的当前位置和0的位置交换。

```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;
const int maxn = 100010;
int pos[maxn];
int main() {
    int n, ans = 0;
    scanf("%d", &n);
    int left = n - 1, num;
    for(int i = 0; i < n; i++) {
        scanf("%d", &num);
        pos[num] = i;
        if(num == i && num != 0) {
            left--;
        }
    }
    int k = 1;
    while(left > 0) {
        if(pos[0] == 0) {
            while(k < n) {
                if(pos[k] != k) {
                    swap(pos[0], pos[k]);
                    ans++;
                    break;
                }
                k++;
            }
        }
    while(pos[0] != 0) {
        swap(pos[0], pos[pos[0]]);
        ans++;
        left--;
    }
    }
    printf("%d\n", ans);
    return 0;
}

```