---
title: 1013 Battle Over Cities (25)（25 分）
date: 2018-08-23 16:20:50
tags: PAT
categories: 题解集
---

1013 Battle Over Cities (25)（25 分）
It is vitally important to have all the cities connected by highways in a war. If a city is occupied by the enemy, all the highways from/toward that city are closed. We must know immediately if we need to repair any other highways to keep the rest of the cities connected. Given the map of cities which have all the remaining highways marked, you are supposed to tell the number of highways need to be repaired, quickly.

For example, if we have 3 cities and 2 highways connecting city~1~-city~2~ and city~1~-city~3~. Then if city~1~ is occupied by the enemy, we must have 1 highway repaired, that is the highway city~2~-city~3~.

Input

Each input file contains one test case. Each case starts with a line containing 3 numbers N (&lt1000), M and K, which are the total number of cities, the number of remaining highways, and the number of cities to be checked, respectively. Then M lines follow, each describes a highway by 2 integers, which are the numbers of the cities the highway connects. The cities are numbered from 1 to N. Finally there is a line containing K numbers, which represent the cities we concern.

Output

For each of the K cities, output in a line the number of highways need to be repaired if that city is lost.

Sample Input
```
3 2 3
1 2
1 3
1 2 3
```
Sample Output
```
1
0
0
```


题目大意：
给定一个无向图并规定：当删除图中某个顶点时，将会同时把与之连接的边一起删除，接下来给出k个查询，每个查询给出一个欲删除的顶点编号，求删除该顶点后需要增加多少边，才能使图连通。

分析：给定一个无向图，如何计算需要增加的边，使得整个图连通。
显然需要增加的边数等于连通块个数减1
求解一个无向图的连通块个数一般有两种方法：
1. 图的遍历：在遍历图的过程中总是每次访问单个连通块，并将该连通块内的所有顶点都标记为已访问，然后去访问下个连通块，在访问过程中同时计数遍历的连通快数
2. 并查集：判断无向图每条边的两个顶点是否在一个集合内，如果在同一个集合内，则不作处理；否则将这两个顶点加入同一个集合。最后统计集合个数
关于删除顶点，当访问回到该顶点时返回即可。
1 遍历图计算连通块
```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<vector>
#include<cstring>
#include<algorithm>
using namespace std;
const int maxn = 1111;
vector<int> G[maxn];
bool vis[maxn];
int currentPoint;
void dfs(int v) {
    if(v == currentPoint) {
        return ;
    }
    vis[v] = true;
    for(int i = 0; i < G[v].size(); i++) {
        if(vis[G[v][i]] == false) {
            dfs(G[v][i]);
        }
    }
}
int n, m, k;
int main() {
    scanf("%d%d%d", &n, &m, &k);
    for(int i = 0; i < m; i++) {
        int a, b;
        scanf("%d%d", &a, &b);
        G[a].push_back(b);
        G[b].push_back(a);
    }
    for(int query = 0; query < k; query++) {
        scanf("%d", &currentPoint);
        memset(vis, false, sizeof(vis));
        int block = 0;
        for(int i = 1; i <= n; i++) {
            if(i != currentPoint && vis[i] == false) {
                dfs(i);
                block++;
            }
        }
        printf("%d\n", block - 1);
    }
    return 0;
}

```

2 并查集求连通块

```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<vector>
#include<cstring>
#include<algorithm>
using namespace std;
const int maxn = 1111;
vector<int> G[maxn];
int father[maxn];
bool vis[maxn];
int findFather(int x) {
    int a = x;
    while(x != father[x]) {
        x = father[x];
    }
    while(a != father[a]) {
        int z = a;
        a = father[a];
        father[z] = x;
    }
    return x;
}
void Union(int a, int b) {
    int faA = findFather(a);
    int faB = findFather(b);
    if(faA != faB) {
        father[faA] = father[faB];
    }
}
void init() {
    for(int i = 1; i < maxn; i++) {
        father[i] = i;
        vis[i] = false;
    }
}
int n, m, k;
int main() {
    scanf("%d%d%d", &n, &m, &k);
    for(int i = 0; i < m; i++) {
        int a, b;
        scanf("%d%d", &a, &b);
        G[a].push_back(b);
        G[b].push_back(a);
    }
    int currentPoint;
    for(int query = 0; query < k; query++) {
        scanf("%d", &currentPoint);
        init();
        for(int i = 1; i <= n; i++) {
            for(int j = 0; j < G[i].size(); j++) {
                int u = i, v = G[i][j];
                if(u == currentPoint || v == currentPoint) {
                    continue;
                }
                Union(u, v);
            }
        }
        int block = 0;
        for(int i = 1; i <= n; i++) {
            if(i == currentPoint) {
                continue;
            }
            int fai = findFather(i);
            if(vis[fai] == false) {
                block++;
                vis[fai] = true;
            }
        }
        printf("%d\n", block - 1);
    }
    return 0;
}

```