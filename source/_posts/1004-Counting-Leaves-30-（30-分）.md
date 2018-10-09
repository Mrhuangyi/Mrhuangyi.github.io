---
title: 1004 Counting Leaves (30)（30 分）
date: 2018-08-19 15:36:29
tags: PAT
categories: 题解集
---

1004 Counting Leaves (30)（30 分）
A family hierarchy is usually presented by a pedigree tree. Your job is to count those family members who have no child.

Input

Each input file contains one test case. Each case starts with a line containing 0 < N < 100, the number of nodes in a tree, and M (< N), the number of non-leaf nodes. Then M lines follow, each in the format:

ID K ID[1] ID[2] ... ID[K]
where ID is a two-digit number representing a given non-leaf node, K is the number of its children, followed by a sequence of two-digit ID's of its children. For the sake of simplicity, let us fix the root ID to be 01.

Output

For each test case, you are supposed to count those family members who have no child for every seniority level starting from the root. The numbers must be printed in a line, separated by a space, and there must be no extra space at the end of each line.

The sample case represents a tree with only 2 nodes, where 01 is the root and 02 is its only child. Hence on the root 01 level, there is 0 leaf node; and on the next level, there is 1 leaf node. Then we should output "0 1" in a line.

Sample Input
```
2 1
01 1 02
```
Sample Output
```
0 1
```
题目大意：给出一棵二叉树，遍历该树，问该树的每一层有多少叶子结点。
1深度优先搜索
用邻接表来存储树，用一个leaf数组存放每层的叶子结点个数，用maxh记录树的深度。
dfs函数里先更新深度maxh，再判断当前结点是否为叶子结点，以此来决定是否要对leaf数组进行自增，在枚举完所有子结点后进入下一层

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
const int maxn = 110;
vector<int> G[maxn];
int leaf[maxn] = {0};
int maxh = 1;
void dfs(int index, int h) {
    maxh = max(h, maxh);
    if(G[index].size() == 0) {
        leaf[h]++;
        return;
    }
    for(int i = 0; i < G[index].size(); i++) {
        dfs(G[index][i], h + 1);
    }
}
int main()
{
    int n, m, parent, child, k;
    scanf("%d%d", &n, &m);
    for(int i = 0; i < m; i++) {
        scanf("%d%d", &parent, &k);
        for(int j = 0; j < k; j++) {
            scanf("%d", &child);
            G[parent].push_back(child);
        }
    }
    dfs(1, 1);
    printf("%d", leaf[1]);
    for(int i = 2; i <= maxh; i++) {
        printf(" %d", leaf[i]);
    }
    return 0;
}

```

2 广度优先搜索
bfs前要先将根结点压入队列q，然后再开始bfs。开始bfs时，先把队首元素弹出，同时更新最大深度maxh，之后判断当前访问节点是否为叶子结点，最后将所有子结点压入队列。

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
const int maxn = 110;
vector<int> G[maxn];
int h[maxn] = {0};
int leaf[maxn] = {0};
int maxh = 0;
void bfs() {
    queue<int> q;
    q.push(1);
    while(!q.empty()) {
        int id = q.front();
        q.pop();
        maxh = max(maxh, h[id]);
        if(G[id].size() == 0) {
            leaf[h[id]]++;
        }
        for(int i = 0; i < G[id].size(); i++) {
            h[G[id][i]] = h[id] + 1;
            q.push(G[id][i]);
        }
    }
}
int main()
{
    int n, m, parent, child, k;
    scanf("%d%d", &n, &m);
    for(int i = 0; i < m; i++) {
        scanf("%d%d", &parent, &k);
        for(int j = 0; j < k; j++) {
            scanf("%d", &child);
            G[parent].push_back(child);
        }
    }
    h[1] = 1;
    bfs();
    for(int i = 1; i <= maxh; i++) {
        if(i == 1) {
            printf("%d", leaf[i]);
        } else {
            printf(" %d", leaf[i]);
        }
    }
    return 0;
}

```