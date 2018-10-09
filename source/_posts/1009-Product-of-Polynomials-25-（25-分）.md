---
title: 1009 Product of Polynomials (25)（25 分）
date: 2018-07-20 14:23:07
tags: PAT
categories: 题解集
---


1009 Product of Polynomials (25)（25 分）
This time, you are supposed to find A*B where A and B are two polynomials.

Input Specification:

Each input file contains one test case. Each case occupies 2 lines, and each line contains the information of a polynomial: K N1 a~N1~ N2 a~N2~ ... NK a~NK~, where K is the number of nonzero terms in the polynomial, Ni and a~Ni~ (i=1, 2, ..., K) are the exponents and coefficients, respectively. It is given that 1 <= K <= 10, 0 <= NK < ... < N2 < N1 <=1000.

Output Specification:

For each test case you should output the product of A and B in one line, with the same format as the input. Notice that there must be NO extra space at the end of each line. Please be accurate up to 1 decimal place.

Sample Input
```
2 1 2.4 0 3.2
2 2 1.5 1 0.5
```
Sample Output
```
3 3 3.6 2 6.0 1 1.6
```
题目大意：给定两个多项式，求两个多项式的乘积。
分析;先获得第一个多项式的系数，再输入第二个多项式的时候循环相乘，得到所有非零项。

```cpp
#include<cstdio>
#include<iostream>
using namespace std;
struct Poly {
    int exp;
    double cof;
}Poly[1001];
double ans[2001];
int main() {
    int n, m, number = 0;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d %lf", &Poly[i].exp, &Poly[i].cof);
    }
    scanf("%d", &m);
    for(int i = 0; i < m; i++) {
        int exp;
        double cof;
        scanf("%d %lf", &exp, &cof);
        for(int j = 0; j < n; j++) {
            ans[exp + Poly[j].exp] += (cof * Poly[j].cof);
        }
    }
    for(int i = 0; i <= 2000; i++) {
        if(ans[i] != 0.0) {
            number++;
        }
    }
    printf("%d", number);
    for(int i = 2000; i >= 0; i--) {
        if(ans[i] != 0.0) {
            printf(" %d %.1f", i, ans[i]);
        }
    }
    return 0;
}

```