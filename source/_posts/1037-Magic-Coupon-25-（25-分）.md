---
title: 1037 Magic Coupon (25)（25 分）
date: 2018-07-29 15:37:17
tags: PAT
categories: 题解集
---

The magic shop in Mars is offering some magic coupons. Each coupon has an integer N printed on it, meaning that when you use this coupon with a product, you may get N times the value of that product back! What is more, the shop also offers some bonus product for free. However, if you apply a coupon with a positive N to this bonus product, you will have to pay the shop N times the value of the bonus product... but hey, magically, they have some coupons with negative N's!

For example, given a set of coupons {1 2 4 -1}, and a set of product values {7 6 -2 -3} (in Mars dollars M\$) where a negative value corresponds to a bonus product. You can apply coupon 3 (with N being 4) to product 1 (with value M\$7) to get M\$28 back; coupon 2 to product 2 to get M\$12 back; and coupon 4 to product 4 to get M\$3 back. On the other hand, if you apply coupon 3 to product 4, you will have to pay M\$12 to the shop.

Each coupon and each product may be selected at most once. Your task is to get as much money back as possible.

Input Specification:

Each input file contains one test case. For each case, the first line contains the number of coupons NC, followed by a line with NC coupon integers. Then the next line contains the number of products NP, followed by a line with NP product values. Here 1<= NC, NP <= 10^5^, and it is guaranteed that all the numbers will not exceed 2^30^.

Output Specification:

For each test case, simply print in a line the maximum amount of money you can get back.

Sample Input:
```
4
1 2 4 -1
4
7 6 -2 -3
```
Sample Output:
```
43
```
题目大意：
给出两个集合，从这两个集合里面选出数量相同的元素进行一对一相乘，求能够得到的最大乘积之和。

贪心策略：
对每个集合，将正数和负数分开考虑，将每个集合里的整数从大到小排序；将每个集合里的负数从小到大排序，然后同位置的正数与正数相乘，负数与负数相乘。
```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;
const int maxn = 100010;
int a[maxn], b[maxn];
int main() {
    int n, m;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }
    scanf("%d", &m);
    for(int i = 0; i < m; i++) {
        scanf("%d", &b[i]);
    }
    sort(a, a + n);
    sort(b, b + m);
    int i = 0, j;
    long long ans = 0;
    while(i < n && i < m && a[i] < 0 && b[i] < 0) {
        ans += a[i] * b[i];
        i++;
    }
    i = n - 1;
    j = m - 1;
    while(i >= 0 && j >= 0 && a[i] > 0 && b[j] > 0) {
        ans += a[i] * b[j];
        i--;
        j--;
    }
    printf("%lld\n", ans);
    return 0;
}

```