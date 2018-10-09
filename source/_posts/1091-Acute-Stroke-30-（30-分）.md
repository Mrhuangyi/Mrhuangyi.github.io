---
title: 1091 Acute Stroke (30)（30 分）
date: 2018-08-13 15:09:37
tags: PAT
categories: 题解集
---

1091 Acute Stroke (30)（30 分）
One important factor to identify acute stroke (急性脑卒中) is the volume of the stroke core. Given the results of image analysis in which the core regions are identified in each MRI slice, your job is to calculate the volume of the stroke core.

Input Specification:

Each input file contains one test case. For each case, the first line contains 4 positive integers: M, N, L and T, where M and N are the sizes of each slice (i.e. pixels of a slice are in an M by N matrix, and the maximum resolution is 1286 by 128); L (<=60) is the number of slices of a brain; and T is the integer threshold (i.e. if the volume of a connected core is less than T, then that core must not be counted).

Then L slices are given. Each slice is represented by an M by N matrix of 0's and 1's, where 1 represents a pixel of stroke, and 0 means normal. Since the thickness of a slice is a constant, we only have to count the number of 1's to obtain the volume. However, there might be several separated core regions in a brain, and only those with their volumes no less than T are counted. Two pixels are "connected" and hence belong to the same region if they share a common side, as shown by Figure 1 where all the 6 red pixels are connected to the blue one.

\ Figure 1

Output Specification:

For each case, output in a line the total volume of the stroke core.

Sample Input:
```
3 4 5 2
1 1 1 1
1 1 1 1
1 1 1 1
0 0 1 1
0 0 1 1
0 0 1 1
1 0 1 1
0 1 0 0
0 0 0 0
1 0 1 1
0 0 0 0
0 0 0 0
0 0 0 1
0 0 0 1
1 0 0 0
```
Sample Output:
```
26
```
题目大意：
给出一个三维数组，数组元素的取值为0或1。与某一个元素相邻的元素为其上下左右前后6个方向的邻接元素。若干个相邻元素的1称为一个块，如果块中1的个数不小于t，则称这个块为卒中核心区。要求所有卒中核心区中1的个数之和。

基本思路：三维广度优先搜索。枚举三维数组的每一个位置，如果为0，则跳过；如果为1，则使用bfs查询与该位置相邻的6个位置，递归判断他们是否为1。为了防止重复判断，用一个inq数组标记每个位置是否已经入队。
```cpp
#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include<queue>
using namespace std;
struct node {
    int x, y, z;
}Node;
int n, m, slice, t;
int pixel[1290][130][61];
bool inq[1290][130][61] = {false};
int X[6] = {0, 0, 0, 0, 1, -1};
int Y[6] = {0, 0, 1, -1, 0, 0};
int Z[6] = {1, -1, 0, 0, 0, 0};
bool judge(int x, int y, int z) {
    if(x >= n || x < 0 || y >= m || y < 0 || z >= slice || z < 0) {
        return false;
    }
    if(pixel[x][y][z] == 0 || inq[x][y][z] == true) {
        return false;
    }
    return true;
}
int bfs(int x, int y, int z) {
    int tot = 0;
    queue<node> q;
    Node.x = x, Node.y = y, Node.z = z;
    q.push(Node);
    inq[x][y][z] = true;
    while(!q.empty()) {
        node top = q.front();
        q.pop();
        tot++;
        for(int i = 0; i < 6; i++) {
            int newx = top.x + X[i];
            int newy = top.y + Y[i];
            int newz = top.z + Z[i];
            if(judge(newx, newy, newz)) {
                Node.x = newx;
                Node.y = newy;
                Node.z = newz;
                q.push(Node);
                inq[newx][newy][newz] = true;
            }
        }
    }
    if(tot >= t) {
        return tot;
    } else {
        return 0;
    }
}
int main()
{
    scanf("%d%d%d%d", &n, &m, &slice, &t);
    for(int z = 0; z < slice; z++) {
        for(int x = 0; x < n; x++) {
            for(int y = 0; y < m; y++) {
                scanf("%d", &pixel[x][y][z]);
            }
        }
    }
    int ans = 0;
    for(int z = 0; z < slice; z++) {
        for(int x = 0; x < n; x++) {
            for(int y = 0; y < m; y++) {
                if(pixel[x][y][z] == 1 && inq[x][y][z] == false) {
                    ans += bfs(x, y, z);
                }
            }
        }
    }
    printf("%d\n", ans);
    return 0;
}

```