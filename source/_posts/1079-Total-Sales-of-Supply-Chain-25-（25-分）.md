---
title: 1079 Total Sales of Supply Chain (25)（25 分）
date: 2018-08-14 15:57:46
tags: PAT
categories: 题解集
---

1079 Total Sales of Supply Chain (25)（25 分）
A supply chain is a network of retailers（零售商）, distributors（经销商）, and suppliers（供应商）-- everyone involved in moving a product from supplier to customer.

Starting from one root supplier, everyone on the chain buys products from one's supplier in a price P and sell or distribute them in a price that is r% higher than P. Only the retailers will face the customers. It is assumed that each member in the supply chain has exactly one supplier except the root supplier, and there is no supply cycle.

Now given a supply chain, you are supposed to tell the total sales from all the retailers.

Input Specification:

Each input file contains one test case. For each case, the first line contains three positive numbers: N (<=10^5^), the total number of the members in the supply chain (and hence their ID's are numbered from 0 to N-1, and the root supplier's ID is 0); P, the unit price given by the root supplier; and r, the percentage rate of price increment for each distributor or retailer. Then N lines follow, each describes a distributor or retailer in the following format:

K~i~ ID[1] ID[2] ... ID[K~i~]

where in the i-th line, K~i~ is the total number of distributors or retailers who receive products from supplier i, and is then followed by the ID's of these distributors or retailers. K~j~ being 0 means that the j-th member is a retailer, then instead the total amount of the product will be given after K~j~. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print in one line the total sales we can expect from all the retailers, accurate up to 1 decimal place. It is guaranteed that the number will not exceed 10^10^.

Sample Input:
```
10 1.80 1.00
3 2 3 5
1 9
1 4
1 7
0 7
2 6 1
1 8
0 9
0 4
0 3
```
Sample Output:
```
42.4
```
题目大意：给出一棵树根唯一的销售供应的树，在树根处货物的价格为p，然后从根节点每往子结点走一层，盖层的货物价格会在父亲结点的价格上上涨r%。给出每个叶结点的货物量，求出价格之和。

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
struct node {
    double data;
    vector<int> child;
}Node[maxn];
int n;
double p, r, ans = 0;
void dfs(int index, int depth) {
    if(Node[index].child.size() == 0) {
        ans += Node[index].data * pow(1 + r, depth);
        return ;
    }
    for(int i = 0; i < Node[index].child.size(); i++) {
        dfs(Node[index].child[i], depth + 1);
    }
}
int main()
{
    int k, child;
    scanf("%d%lf%lf", &n, &p, &r);
    r /= 100;
    for(int i = 0; i < n; i++) {
        scanf("%d", &k);
        if(k == 0) {
            scanf("%lf", &Node[i].data);
        } else {
            for(int j = 0; j < k; j++) {
                scanf("%d", &child);
                Node[i].child.push_back(child);
            }
        }
    }
    dfs(0, 0);
    printf("%.1f\n", p * ans);
    return 0;
}

```