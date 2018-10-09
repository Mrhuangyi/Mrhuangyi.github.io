---
title: 1046 Shortest Distance (20)（20 分）
date: 2018-07-19 20:56:46
tags: PAT
categories: 题解集
---

1046 Shortest Distance (20)（20 分）
The task is really simple: given N exits on a highway which forms a simple cycle, you are supposed to tell the shortest distance between any pair of exits.

Input Specification:

Each input file contains one test case. For each case, the first line contains an integer N (in [3, 10^5^]), followed by N integer distances D~1~ D~2~ ... D~N~, where D~i~ is the distance between the i-th and the (i+1)-st exits, and D~N~ is between the N-th and the 1st exits. All the numbers in a line are separated by a space. The second line gives a positive integer M (<=10^4^), with M lines follow, each contains a pair of exit numbers, provided that the exits are numbered from 1 to N. It is guaranteed that the total round trip distance is no more than 10^7^.

Output Specification:

For each test case, print your results in M lines, each contains the shortest distance between the corresponding given pair of exits.

Sample Input:
```
5 1 2 4 14 9
3
1 3
2 5
4 1
```
Sample Output:
```
3
10
7
```
题目大意：有n个结点围成一个圈，相邻两个结点之间的距离已知，且每次只能移动到相邻点。给出m次询问，每次给出两个编号a，b，问从a到b的最短距离是多少。

分析：用dis[i]表示1号结点按顺时针方向到达i号节点顺时针方向下一个节点的距离，sum表示一圈的总距离，a[i]表示i号与i+1号顶点的距离。对于每次询问，结果其实就是dis(left,right)和sum-dis(left,right)中的较小值。
dis数组和sum在读入数据时就可进行预处理来得到，以此来降低时间复杂度，对于每次询问dis(left,right) = dis[right-1] - dis[left-1].
```cpp
#include<cstdio>
#include<algorithm>
using namespace std;
const int maxn = 100005;
int dis[maxn], a[maxn];
int main() {
    int sum = 0, query, n, left, right;
    scanf("%d", &n);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
        sum += a[i];
        dis[i] = sum;
    }
    scanf("%d", &query);
    for(int i = 0; i < query; i++) {
        scanf("%d %d", &left, &right);
        if(left > right) {
            swap(left, right);
        }
        int temp = dis[right - 1] - dis[left - 1];
        printf("%d\n", min(temp, sum - temp));
    }
    return 0;
}

```