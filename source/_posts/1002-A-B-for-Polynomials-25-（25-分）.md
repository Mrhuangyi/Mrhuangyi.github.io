---
title: 1002 A+B for Polynomials (25)（25 分）
date: 2018-07-20 14:06:13
tags: PAT
categories: 题解集
---

1002 A+B for Polynomials (25)（25 分）
This time, you are supposed to find A+B where A and B are two polynomials.

Input

Each input file contains one test case. Each case occupies 2 lines, and each line contains the information of a polynomial: K N1 a~N1~ N2 a~N2~ ... NK a~NK~, where K is the number of nonzero terms in the polynomial, Ni and a~Ni~ (i=1, 2, ..., K) are the exponents and coefficients, respectively. It is given that 1 <= K <= 10，0 <= NK < ... < N2 < N1 <=1000.

Output

For each test case you should output the sum of A and B in one line, with the same format as the input. Notice that there must be NO extra space at the end of each line. Please be accurate to 1 decimal place.

Sample Input
```
2 1 2.4 0 3.2
2 2 1.5 1 0.5
```
Sample Output
```
3 2 1.5 1 2.9 0 3.2
```
题目大意：两个多项式求和问题，给出两行，一行表示一个多项式，第一个数表示多项式中系数非零项的项数，后面每两个数表示一项，分别指代该项的幂次和系数。
分析：可以直接开一个p[maxn]数组来表示多项式，p[n]表示幂次为n的项的系数。
输出要求按照幂次从大到小的顺序，格式上保留一位小数。注意正负相抵的情况。

```cpp
#include<cstdio>
#include<iostream>
using namespace std;
const int maxn = 1111;
double p[maxn] = {};
int main() {
    int k, n, count = 0;
    double a;
    scanf("%d", &k);
    for(int i = 0; i < k; i++) {
        scanf("%d %lf", &n, &a);
        p[n] += a;
    }
    scanf("%d", &k);
    for(int i = 0; i < k; i++) {
        scanf("%d %lf", &n, &a);
        p[n] += a;
    }
    for(int i = 0; i < maxn; i++) {
        if(p[i] != 0) {
            count++;
        }
    }
    printf("%d", count);
    for(int i = maxn; i >= 0; i--) {
        if(p[i] != 0) {
            printf(" %d %.1f", i, p[i]);
        }
    }
    return 0;
}

```