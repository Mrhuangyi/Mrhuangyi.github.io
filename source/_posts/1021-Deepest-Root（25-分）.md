---
title: 1021 Deepest Root（25 分）
date: 2018-08-31 10:28:18
tags: PAT
categories: 题解集
---
1021 Deepest Root（25 分）
A graph which is connected and acyclic can be considered a tree. The hight of the tree depends on the selected root. Now you are supposed to find the root that results in a highest tree. Such a root is called the deepest root.

Input Specification:
Each input file contains one test case. For each case, the first line contains a positive integer N (≤10
​4
​​ ) which is the number of nodes, and hence the nodes are numbered from 1 to N. Then N−1 lines follow, each describes an edge by given the two adjacent nodes' numbers.

Output Specification:
For each test case, print each of the deepest roots in a line. If such a root is not unique, print them in increasing order of their numbers. In case that the given graph is not a tree, print Error: K components where K is the number of connected components in the graph.

Sample Input 1:
```
5
1 2
1 3
1 4
2 5
```
Sample Output 1:
```
3
4
5
```
Sample Input 2:
```
5
1 3
1 4
2 5
3 4
```
Sample Output 2:
```
Error: 2 components
```
题目大意：给出n个结点和n-1条边，问它们能否形成一棵n个结点的树，如果能，从中选出结点作为树根，使整棵树的高度最大。输出所有满足要求的可以作为树根的结点。
思路：
1 由于连通、边数为n-1的图一定是一棵树，因此需要判断给定数据是否能使图连通。使用并查集判断方法：
每读入一条边的两个端点，判断这两个端点是否属于相同的集合，如果不同，则将它们合并到一个集合中，当处理完所有边后根据最终产生的集合个数是否为1来判断给定的图是否连通。
2 确定图连通后，则确定了树，选择合适根结点使树高最大的做法为：
先任意选择一个结点，从该节点开始遍历整棵树，获取能达到的最深的结点，记为集合A；然后从集合A中任意一个结点出发遍历整棵树，获取能达到的最深顶点，记为结点集合B。集合A与B的并集就是所求结果。
```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<vector>
#include<algorithm>
using namespace std;
const int maxn = 100010;
vector<int> G[maxn];
bool isRoot[maxn];
int father[maxn];
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
        father[faA] = faB;
    }
}
void init(int n) {
    for(int i = 1; i <= n; i++) {
        father[i] = i;
    }
}
int blockCnt(int n) {
    int cnt = 0;
    for(int i = 1; i <= n; i++) {
        isRoot[findFather(i)] = true;
    }
    for(int i = 1; i <= n; i++) {
        cnt += isRoot[i];
    }
    return cnt;
}
int maxH = 0;
vector<int> temp, ans;
void dfs(int u, int height, int pre) {
    if(height > maxH) {
        temp.clear();
        temp.push_back(u);
        maxH = height;
    } else if(height == maxH) {
        temp.push_back(u);
    }
    for(int i = 0; i < G[u].size(); i++) {
        if(G[u][i] == pre) {
            continue;
        }
        dfs(G[u][i], height + 1, u);
    }
}
int main() {
    int a, b, n;
    scanf("%d", &n);
    init(n);
    for(int i = 1; i < n; i++) {
        scanf("%d%d", &a, &b);
        G[a].push_back(b);
        G[b].push_back(a);
        Union(a, b);
    }
    int block = blockCnt(n);
    if(block != 1) {
        printf("Error: %d components\n", block);
    } else {
        dfs(1, 1, -1);
        ans = temp;
        dfs(ans[0], 1, -1);
        for(int i = 0; i < temp.size(); i++) {
            ans.push_back(temp[i]);
        }
        sort(ans.begin(), ans.end());
        printf("%d\n", ans[0]);
        for(int i = 1; i < ans.size(); i++) {
            if(ans[i] != ans[i - 1]) {
                printf("%d\n", ans[i]);
            }
        }
    }
    return 0;
}

```