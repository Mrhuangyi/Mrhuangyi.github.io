---
title: 1058 A+B in Hogwarts (20)（20 分）
date: 2018-07-22 11:08:22
tags: PAT
categories: 题解集
---


1058 A+B in Hogwarts (20)（20 分）
If you are a fan of Harry Potter, you would know the world of magic has its own currency system -- as Hagrid explained it to Harry, "Seventeen silver Sickles to a Galleon and twenty-nine Knuts to a Sickle, it's easy enough." Your job is to write a program to compute A+B where A and B are given in the standard form of "Galleon.Sickle.Knut" (Galleon is an integer in [0, 10^7^], Sickle is an integer in [0, 17), and Knut is an integer in [0, 29)).

Input Specification:

Each input file contains one test case which occupies a line with A and B in the standard form, separated by one space.

Output Specification:

For each test case you should output the sum of A and B in one line, with the same format as the input.

Sample Input:
```
3.2.1 10.16.27
```
Sample Output:
```
14.1.28
```
分析，自定义进制数的求和注意保留进位，最高位没有进位限制
```cpp
#include<cstdio>
#include<iostream>
using namespace std;
int main() {
    int a[3], b[3], c[3];
    scanf("%d.%d.%d %d.%d.%d", &a[0], &a[1], &a[2], &b[0], &b[1], &b[2]);
    int carry = 0;
    c[2] = (a[2] + b[2]) % 29;
    carry = (a[2] + b[2]) / 29;
    c[1] = (a[1] + b[1] + carry) % 17;
    carry = (a[1] + b[1] + carry) / 17;
    c[0] = a[0] + b[0] + carry;
    printf("%d.%d.%d", c[0], c[1], c[2]);
    return 0;
}

```