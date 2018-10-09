---
title: 1094 The Largest Generation (25)（25 分）
date: 2018-08-18 14:17:13
tags: PAT
categories: 题解集
---

1094 The Largest Generation (25)（25 分）
A family hierarchy is usually presented by a pedigree tree where all the nodes on the same level belong to the same generation. Your task is to find the generation with the largest population.

Input Specification:

Each input file contains one test case. Each case starts with two positive integers N (&lt100) which is the total number of family members in the tree (and hence assume that all the members are numbered from 01 to N), and M (&ltN) which is the number of family members who have children. Then M lines follow, each contains the information of a family member in the following format:

ID K ID[1] ID[2] ... ID[K]

where ID is a two-digit number representing a family member, K (&gt0) is the number of his/her children, followed by a sequence of two-digit ID's of his/her children. For the sake of simplicity, let us fix the root ID to be 01. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print in one line the largest population number and the level of the corresponding generation. It is assumed that such a generation is unique, and the root level is defined to be 1.

Sample Input:
```
23 13
21 1 23
01 4 03 02 04 05
03 3 06 07 08
06 2 12 13
13 1 21
08 2 15 16
02 2 09 10
11 2 19 20
17 1 22
05 1 11
07 1 14
09 1 17
10 1 18
```
Sample Output:
```
9 4
```
题目大意：给定树的结点个数n，非叶子节点个数m，然后输入m个非叶子结点各自的孩子结点编号，输出结点个数最多的一层的结点个数以及层号

思路：定义一个hashTable数组用来记录每一层的结点个数
写一个dfs函数，用来记录当前访问的结点编号index与该结点的层号level，进入函数，先令hashTable[level]加1，之后遍历结点index的所有孩子结点，对每个孩子结点进行递归，递归时level+1
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
vector<int> node[maxn];
int hashTable[maxn] = {0};
void dfs(int index, int level) {
    hashTable[level]++;
    for(int j = 0; j < node[index].size(); j++) {
        dfs(node[index][j], level + 1);
    }
}
int main()
{
    int n, m, parent, k, child;
    scanf("%d%d", &n, &m);
    for(int i = 0; i < m; i++) {
        scanf("%d%d", &parent, &k);
        for(int j = 0; j < k; j++) {
            scanf("%d", &child);
            node[parent].push_back(child);
        }
    }
    dfs(1, 1);
    int maxLevel = -1, maxValue = 0;
    for(int i = 1; i < maxn; i++) {
        if(hashTable[i] > maxValue) {
            maxValue = hashTable[i];
            maxLevel = i;
        }
    }
    printf("%d %d\n", maxValue, maxLevel);
    return 0;
}

```