---
title: 1068 Find More Coins（30 分）
date: 2018-09-04 14:04:13
tags: PAT
categories: 题解集
---

1068 Find More Coins（30 分）
Eva loves to collect coins from all over the universe, including some other planets like Mars. One day she visited a universal shopping mall which could accept all kinds of coins as payments. However, there was a special requirement of the payment: for each bill, she must pay the exact amount. Since she has as many as 10
​4
​​  coins with her, she definitely needs your help. You are supposed to tell her, for any given amount of money, whether or not she can find some coins to pay for it.

Input Specification:
Each input file contains one test case. For each case, the first line contains 2 positive numbers: N (≤10
​4
​​ , the total number of coins) and M (≤10
​2
​​ , the amount of money Eva has to pay). The second line contains N face values of the coins, which are all positive numbers. All the numbers in a line are separated by a space.

Output Specification:
For each test case, print in one line the face values V
​1
​​ ≤V
​2
​​ ≤⋯≤V
​k
​​  such that V
​1
​​ +V
​2
​​ +⋯+V
​k
​​ =M. All the numbers must be separated by a space, and there must be no extra space at the end of the line. If such a solution is not unique, output the smallest sequence. If there is no solution, output "No Solution" instead.

Note: sequence {A[1], A[2], ...} is said to be "smaller" than sequence {B[1], B[2], ...} if there exists k≥1 such that A[i]=B[i] for all i<k, and A[k] < B[k].

Sample Input 1:
```
8 9
5 9 8 7 2 3 4 1
```
Sample Output 1:
```
1 3 5
```
Sample Input 2:
```
4 8
7 2 4 3
```
Sample Output 2:
```
No Solution
```
题目大意：背包问题，有n枚硬币，给出每枚硬币的价值，现在要用这些硬币去支付价值为m的东西，问是否存在这样的方案使选择用来支付的硬币价值之和恰好为m，如果存在从小到大输出硬币的价值，如果有多种方案，则输出“字典序“”最小的

01背包问题：
状态转移方程：dp[i][v] = max{dp[i - 1][v], dp[i - 1][v - w[i] + c[i]}
开一个bool型二维数组choice[i][v]用来记录是选择了哪个策略，即是放第i件物品还是不放第i件物品。
无解条件为dp[m] != m
求解dp数组时，如果两种策略的大小相等，选择放第i件物品的策略。
```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<string>
#include<vector>
#include<map>
#include<algorithm>
using namespace std;
const int maxn = 10010;
const int maxv = 110;
int w[maxn], dp[maxv] = {0};
bool choice[maxn][maxv], flag[maxn];
bool cmp(int a, int b) {
    return a > b;
}
int main() {
    int n, m;
    scanf("%d%d", &n, &m);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &w[i]);
    }
    sort(w + 1, w + n + 1, cmp);
    for(int i = 1; i <= n; i++) {
        for(int v = m; v >= w[i]; v--) {
            if(dp[v] <= dp[v - w[i]] + w[i]) {
                dp[v] = dp[v - w[i]] + w[i];
                choice[i][v] = 1;
            } else {
                choice[i][v] = 0;
            }
        }
    }
    if(dp[m] != m) {
        printf("No Solution");
    } else {
        int k = n, num = 0, v = m;
        while(k >= 0) {
            if(choice[k][v] == 1) {
                flag[k] = true;
                v -= w[k];
                num++;
            } else {
                flag[k] = false;
            }
            k--;
        }
        for(int i = n; i >= 1; i--) {
            if(flag[i] == true) {
                printf("%d", w[i]);
                num--;
                if(num > 0) {
                    printf(" ");
                }
            }
        }
    }
    return 0;
}

```