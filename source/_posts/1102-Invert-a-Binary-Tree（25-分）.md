---
title: 1102 Invert a Binary Tree（25 分）
date: 2018-08-14 15:39:27
tags: PAT
categories: 题解集
---

1102 Invert a Binary Tree（25 分）
The following is from Max Howell @twitter:

Google: 90% of our engineers use the software you wrote (Homebrew), but you can't invert a binary tree on a whiteboard so fuck off.
Now it's your turn to prove that YOU CAN invert a binary tree!

Input Specification:
Each input file contains one test case. For each case, the first line gives a positive integer N (≤10) which is the total number of nodes in the tree -- and hence the nodes are numbered from 0 to N−1. Then N lines follow, each corresponds to a node from 0 to N−1, and gives the indices of the left and right children of the node. If the child does not exist, a - will be put at the position. Any pair of children are separated by a space.

Output Specification:
For each test case, print in the first line the level-order, and then in the second line the in-order traversal sequences of the inverted tree. There must be exactly one space between any adjacent numbers, and no extra space at the end of the line.

Sample Input:
```
8
1 -
- -
0 -
2 7
- -
- -
5 -
4 6
```
Sample Output:
```
3 7 2 6 4 0 5 1
6 5 7 4 3 2 0 1
```
题目大意：二叉树有n个结点，给出每个结点的左右孩子的节点编号，把该二叉树反转，输出反转后二叉树的层序遍历序列和中序遍历序列。

思路：进行后序遍历反转二叉树，在访问根结点时转换lchild和rchild

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
struct node {
    int lchild, rchild;
}Node[maxn];
bool notRoot[maxn] = {false};
int n, num = 0;
void print(int id) {
    printf("%d", id);
    num++;
    if(num < n) {
        printf(" ");
    } else {
        printf("\n");
    }
}
void inorder(int root) {
    if(root == -1) {
        return ;
    }
    inorder(Node[root].lchild);
    print(root);
    inorder(Node[root].rchild);
}
void bfs(int root) {
    queue<int> q;
    q.push(root);
    while(!q.empty()) {
        int now = q.front();
        q.pop();
        print(now);
        if(Node[now].lchild != -1) {
            q.push(Node[now].lchild);
        }
        if(Node[now].rchild != -1) {
            q.push(Node[now].rchild);
        }
    }
}
void postorder(int root) {
    if(root == -1) {
        return ;
    }
    postorder(Node[root].lchild);
    postorder(Node[root].rchild);
    swap(Node[root].lchild, Node[root].rchild);
}
int strTonum(char c) {
    if(c == '-') {
        return -1;
    } else {
        notRoot[c - '0'] = true;
        return c - '0';
    }
}
int findRoot() {
    for(int i = 0; i < n; i++) {
        if(notRoot[i] == false) {
            return i;
        }
    }
}
int main()
{
    char lchild, rchild;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
            getchar();
        scanf("%c %c", &lchild, &rchild);
        Node[i].lchild = strTonum(lchild);
        Node[i].rchild = strTonum(rchild);
    }
    int root = findRoot();
    postorder(root);
    bfs(root);
    num = 0;
    inorder(root);
    return 0;
}

```