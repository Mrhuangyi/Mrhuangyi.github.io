---
title: 1059 Prime Factors (25)（25 分）
date: 2018-07-31 16:10:29
tags: PAT
categories: 题解集
---

Given any positive integer N, you are supposed to find all of its prime factors, and write them in the format N = p~1~\^k~1~ * p~2~\^k~2~ *…*p~m~\^k~m~.

Input Specification:

Each input file contains one test case which gives a positive integer N in the range of long int.

Output Specification:

Factor N in the format N = p~1~\^k~1~ * p~2~\^k~2~ *…*p~m~\^k~m~, where p~i~'s are prime factors of N in increasing order, and the exponent k~i~ is the number of p~i~ -- hence when there is only one p~i~, k~i~ is 1 and must NOT be printed out.

Sample Input:
```
97532468
```
Sample Output:
```
97532468=2^2*11*17*101*1291
```
题目大意：按从小到大将一个整数输出其分解为质因数相乘的形式

1枚举1~sqrt(n)范围内的所有质因子p,判断p是否是n的因子。
2上述步骤结束后若n大于1，说明有且仅有一个大于sqrt(n)的质因子（可能是n本身）
```cpp
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
#include<cstring>
using namespace std;
const int maxn = 100010;
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
int prime[maxn], pNum = 0;
void findPrime() {
    for(int i = 1; i < maxn; i++) {
        if(isPrime(i)) {
            prime[pNum++] = i;
        }
    }
}
struct factor {
    int x, cnt;
}fac[10];
int main() {
    findPrime();
    int n, num = 0;
    scanf("%d", &n);
    if(n == 1) {
        printf("1=1");
    } else {
        printf("%d=", n);
        int sqr = (int)sqrt(1.0 * n);
        for(int i = 0; i < pNum && prime[i] <= sqr; i++) {
            if(n % prime[i] == 0) {
                fac[num].x = prime[i];
                fac[num].cnt = 0;
                while(n % prime[i] == 0) {
                    fac[num].cnt++;
                    n /= prime[i];
                }
                num++;
            }
            if(n == 1) {
                break;
            }
        }
            if(n != 1) {
                fac[num].x = n;
                fac[num++].cnt = 1;
            }
            for(int i = 0; i < num; i++) {
                if(i > 0) {
                    printf("*");
                }
                printf("%d", fac[i].x);
                if(fac[i].cnt > 1) {
                    printf("^%d",fac[i].cnt);
                }
            }
    }
    return 0;
}

```