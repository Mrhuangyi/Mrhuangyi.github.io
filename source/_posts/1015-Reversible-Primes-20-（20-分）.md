---
title: 1015 Reversible Primes (20)（20 分）
date: 2018-07-31 14:46:44
tags: PAT
categories: 题解集
---

A reversible prime in any number system is a prime whose "reverse" in that number system is also a prime. For example in the decimal system 73 is a reversible prime because its reverse 37 is also a prime.

Now given any two positive integers N (< 10^5^) and D (1 < D <= 10), you are supposed to tell if N is a reversible prime with radix D.

Input Specification:

The input file consists of several test cases. Each case occupies a line which contains two integers N and D. The input is finished by a negative N.

Output Specification:

For each test case, print in one line "Yes" if N is a reversible prime with radix D, or "No" if not.

Sample Input:
```
73 10
23 2
23 10
-2
```
Sample Output:
```
Yes
Yes
No
```
题目大意：给出正整数n和进制radix，如果n是素数，且n在radix进制下反转后得到的整数也是素数，则输出Yes，否则，输出No

分析：
1先判断n是否为素数，不是素数直接输出No
2如果n是素数，将n转换为radix进制，判断该数是否素数。
```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
using namespace std;
bool isPrime(int n) {
    if(n <= 1) {
        return false;
    }
    for(int i = 2; i * i <= n; i++) {
        if(n % i == 0) {
            return false;
        }
    }
    return true;
}
int d[111];
int main() {
    int n, radix;
    while(~scanf("%d", &n)) {
        if(n < 0) {
            break;
        }
        scanf("%d", &radix);
        if(isPrime(n) == false) {
            printf("No\n");
        } else {
            int len = 0;
            do {
               d[len++] = n % radix;
               n /= radix;
            } while(n != 0);
            for(int i = 0; i < len; i++) {
                n = n * radix + d[i];
            }
            if(isPrime(n) == true) {
                printf("Yes\n");
            } else {
                printf("No\n");
            }
        }
    }
    return 0;
}

```