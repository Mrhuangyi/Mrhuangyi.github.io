---
title: 1033 To Fill or Not to Fill (25)（25 分）
date: 2018-07-29 15:02:42
tags: PAT
categories: 题解集
---

With highways available, driving a car from Hangzhou to any other city is easy. But since the tank capacity of a car is limited, we have to find gas stations on the way from time to time. Different gas station may give different price. You are asked to carefully design the cheapest route to go.

Input Specification:

Each input file contains one test case. For each case, the first line contains 4 positive numbers: C~max~ (<= 100), the maximum capacity of the tank; D (<=30000), the distance between Hangzhou and the destination city; D~avg~ (<=20), the average distance per unit gas that the car can run; and N (<= 500), the total number of gas stations. Then N lines follow, each contains a pair of non-negative numbers: P~i~, the unit gas price, and D~i~ (<=D), the distance between this station and Hangzhou, for i=1,...N. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print the cheapest price in a line, accurate up to 2 decimal places. It is assumed that the tank is empty at the beginning. If it is impossible to reach the destination, print "The maximum travel distance = X" where X is the maximum possible distance the car can run, accurate up to 2 decimal places.

Sample Input 1:
```
50 1300 12 8
6.00 1250
7.00 600
7.00 150
7.10 0
7.20 200
7.50 400
7.30 1000
6.85 300
```
Sample Output 1:
```
749.17
```
Sample Input 2:
```
50 1300 12 2
7.10 0
7.00 600
```
Sample Output 2:
```
The maximum travel distance = 1200.00
```
题目大意：给定n个加油站的单位油价和离起点的距离，汽车初始时刻处于起点位置，油箱为空，在不超过油箱容量的前提下可以在任意加油站购买任意量的汽油，求从起点到终点的最小花费。如果到不了终点，输出最终的行驶距离。

分析：
1将终点视为单位油价为0，离起点距离为d的加油站，然后将所有加油站按离起点的距离从小到大排序。排序后，如果如果离起点最近的加油站距离不是0，则汽车无法出发，直接输出结果
2如何选择下一个车站的策略：

- 优先前往更低油价的加油站
- 在没有更低油价的加油站时前往油价尽可能低的加油站
- 在没有加油站能够到达时结束

```cpp

#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;
const int maxn = 510;
const int inf = 0x3f3f3f3f;
struct station {
    double price, dis;
}st[maxn];
bool cmp(station a, station b) {
    return a.dis < b.dis;
}
int main() {
    int n;
    double maxc, d, davg;
    scanf("%lf%lf%lf%d", &maxc, &d, &davg, &n);
    for(int i = 0; i < n; i++) {
        scanf("%lf%lf", &st[i].price, &st[i].dis);
    }
    st[n].price = 0;
    st[n].dis = d;
    sort(st, st + n, cmp);
    if(st[0].dis != 0) {
        printf("The maximum travel distance = 0.00\n");
    } else {
        int now = 0;
        double ans = 0, nowTank = 0, maxm = maxc * davg;
        while(now < n) {
            int k = -1;
            double minPrice = inf;
            for(int i = now + 1; i <= n && st[i].dis - st[now].dis <= maxm; i++) {
                if(st[i].price < minPrice) {
                    minPrice = st[i].price;
                    k = i;
                    if(minPrice < st[now].price) {
                        break;
                    }
                }
            }
            if(k == -1) {
                break;
            }
            double need = (st[k].dis - st[now].dis) / davg;
            if(minPrice < st[now].price) {
                if(nowTank < need) {
                    ans += (need - nowTank) * st[now].price;
                    nowTank = 0;
                } else {
                    nowTank -= need;
                }
            } else {
                ans += (maxc - nowTank) * st[now].price;
                nowTank = maxc - need;
            }
            now = k;
        }
        if(now == n) {
            printf("%.2f\n", ans);
        } else {
            printf("The maximum travel distance = %.2f\n", st[now].dis + maxm);
        }
    }
    return 0;
}

```