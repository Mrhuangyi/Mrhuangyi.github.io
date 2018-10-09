---
title: 1090 Highest Price in Supply Chain (25)（25 分）
date: 2018-08-14 16:12:05
tags: PAT
categories: 题解集
---

1090 Highest Price in Supply Chain (25)（25 分）
A supply chain is a network of retailers（零售商）, distributors（经销商）, and suppliers（供应商）-- everyone involved in moving a product from supplier to customer.

Starting from one root supplier, everyone on the chain buys products from one's supplier in a price P and sell or distribute them in a price that is r% higher than P. It is assumed that each member in the supply chain has exactly one supplier except the root supplier, and there is no supply cycle.

Now given a supply chain, you are supposed to tell the highest price we can expect from some retailers.

Input Specification:

Each input file contains one test case. For each case, The first line contains three positive numbers: N (<=10^5^), the total number of the members in the supply chain (and hence they are numbered from 0 to N-1); P, the price given by the root supplier; and r, the percentage rate of price increment for each distributor or retailer. Then the next line contains N numbers, each number S~i~ is the index of the supplier for the i-th member. S~root~ for the root supplier is defined to be -1. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print in one line the highest price we can expect from some retailers, accurate up to 2 decimal places, and the number of retailers that sell at the highest price. There must be one space between the two numbers. It is guaranteed that the price will not exceed 10^10^.

Sample Input:
```
9 1.80 1.00
1 5 4 4 -1 4 5 3 6
```
Sample Output:
```
1.85 2
```
与1079相类似，要求所有叶结点中的最高价格以及这个价格的叶结点个数。
由于不需要考虑点权，所以可以直接用vector数组来存放树，树的最大深度可通过dfs或bfs获得。
```cpp
#include <iostream>
#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>
#include <cmath>
#include<stack>
#include<queue>
using namespace std;
const int maxn = 100010;
vector<int> child[maxn];
double p, r;
int n, maxDepth = 0, num = 0;

void dfs(int index, int depth) {
    if(child[index].size() == 0) {
        if(depth > maxDepth) {
            maxDepth = depth;
            num = 1;
        } else if(depth == maxDepth) {
            num++;
        }
        return ;
    }
    for(int i = 0; i < child[index].size(); i++) {
        dfs(child[index][i], depth + 1);
    }
}
int main()
{
    int fa, root;
    scanf("%d%lf%lf", &n, &p, &r);
    r /= 100;
    for(int i = 0; i < n; i++) {
        scanf("%d", &fa);
        if(fa != -1) {
            child[fa].push_back(i);
        } else {
            root = i;
        }
    }
    dfs(root, 0);
    printf("%.2f %d\n", p * pow(1 + r, maxDepth), num);
    return 0;
}

```