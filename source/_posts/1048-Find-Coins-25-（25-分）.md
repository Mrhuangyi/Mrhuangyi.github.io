---
title: 1048 Find Coins (25)（25 分）
date: 2018-07-27 17:51:59
tags: PAT
categories: 题解集
---


Eva loves to collect coins from all over the universe, including some other planets like Mars. One day she visited a universal shopping mall which could accept all kinds of coins as payments. However, there was a special requirement of the payment: for each bill, she could only use exactly two coins to pay the exact amount. Since she has as many as 10^5^ coins with her, she definitely needs your help. You are supposed to tell her, for any given amount of money, whether or not she can find two coins to pay for it.

Input Specification:

Each input file contains one test case. For each case, the first line contains 2 positive numbers: N (<=10^5^, the total number of coins) and M(<=10^3^, the amount of money Eva has to pay). The second line contains N face values of the coins, which are all positive numbers no more than 500. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print in one line the two face values V~1~ and V~2~ (separated by a space) such that V~1~ + V~2~ = M and V~1~ <= V~2~. If such a solution is not unique, output the one with the smallest V~1~. If there is no solution, output "No Solution" instead.

Sample Input 1:
```
8 15
1 2 8 7 2 4 11 15
```
Sample Output 1:
```
4 11
```
Sample Input 2:
```
7 14
1 8 7 2 4 11 15
```
Sample Output 2:
```
No Solution
```
题目大意：给出n个正整数和一个正整数m，问n个数字里面是否存在一堆数字a和b（a<=b）,使得a+b = m。如果有多对，输出a最小的那一对。
分析：两数之和的问题，考虑哈希思想，当然也可以用二分查找或two pointers做
哈希解法：
1 用int型的哈希数组存放每个数字出现的个数
2 枚举1~m，如果i和m-i都在散列数组里面，并且i == m - i时数字i的个数大于等于2，那么就表示找到了符合的一对数字

```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<map>
#include<algorithm>
using namespace std;
int HashTable[1005];
int main() {
    int n, m, a;
    scanf("%d %d", &n, &m);
    for(int i = 0; i < n; i++) {
        scanf("%d", &a);
        HashTable[a]++;
    }
    for(int i = 1; i < m; i++) {
        if(HashTable[i] && HashTable[m - i]) {
            if(i == m - i && HashTable[i] <= 1) {
                continue;
            }
            printf("%d %d\n", i, m - i);
            return 0;
        }
    }
    printf("No Solution\n");
    return 0;
}

```