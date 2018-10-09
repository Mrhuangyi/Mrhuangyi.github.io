---
title: 1081 Rational Sum (20)（20 分）
date: 2018-07-31 14:36:54
tags: PAT
categories: 题解集
---

Given N rational numbers in the form "numerator/denominator", you are supposed to calculate their sum.

Input Specification:

Each input file contains one test case. Each case starts with a positive integer N (<=100), followed in the next line N rational numbers "a1/b1 a2/b2 ..." where all the numerators and denominators are in the range of "long int". If there is a negative number, then the sign must appear in front of the numerator.

Output Specification:

For each test case, output the sum in the simplest form "integer numerator/denominator" where "integer" is the integer part of the sum, "numerator" < "denominator", and the numerator and the denominator have no common factor. You must output only the fractional part if the integer part is 0.

Sample Input 1:
```
5
2/5 4/15 1/30 -2/60 8/3
```
Sample Output 1:
```
3 1/3
```
Sample Input 2:
```
2
4/3 2/3
```
Sample Output 2:
```
2
```
Sample Input 3:
```
3
1/3 -1/6 1/8
```
Sample Output 3:
```
7/24
```
题目大意：给出n个分数，求分数的和，并按要求输出


```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
using namespace std;
typedef long long LL;
LL gcd(LL a, LL b) {
    return b == 0 ? a : gcd(b, a % b);
}
struct Fraction {
    LL up, down;
};
Fraction reduction(Fraction result) {
    if(result.down < 0) {
        result.up = - result.up;
        result.down = - result.down;
    }
    if(result.up == 0) {
        result.down = 1;
    } else {
        int d = gcd(abs(result.up), abs(result.down));
        result.up /= d;
        result.down /= d;
    }
    return result;
}
Fraction add(Fraction f1, Fraction f2) {
    Fraction result;
    result.up = f1.up * f2.down + f2.up * f1.down;
    result.down = f1.down * f2.down;
    return reduction(result);
}
void show(Fraction r) {
    reduction(r);
    if(r.down == 1) {
        printf("%lld\n", r.up);
    } else if(abs(r.up) > r.down) {
        printf("%lld %lld/%lld\n", r.up / r.down, abs(r.up) % r.down, r.down);
    } else {
        printf("%lld/%lld\n", r.up, r.down);
    }
}
int main() {
    int n;
    scanf("%d", &n);
    Fraction sum, temp;
    sum.up = 0;
    sum.down = 1;
    for(int i = 0; i < n; i++) {
        scanf("%lld/%lld", &temp.up, &temp.down);
        sum = add(sum,temp);
    }
    show(sum);
    return 0;
}

```