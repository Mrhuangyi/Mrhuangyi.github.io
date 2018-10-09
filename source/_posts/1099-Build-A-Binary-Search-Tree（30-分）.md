---
title: 1099 Build A Binary Search Tree（30 分）
date: 2018-08-20 17:08:19
tags: PAT
categories: 题解集
---

1099 Build A Binary Search Tree（30 分）
A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
Both the left and right subtrees must also be binary search trees.
Given the structure of a binary tree and a sequence of distinct integer keys, there is only one way to fill these keys into the tree so that the resulting tree satisfies the definition of a BST. You are supposed to output the level order traversal sequence of that tree. The sample is illustrated by Figure 1 and 2.

![alt](https://images.ptausercontent.com/24c2521f-aaed-4ef4-bac8-3ff562d80a1b.jpg)

Input Specification:
Each input file contains one test case. For each case, the first line gives a positive integer N (≤100) which is the total number of nodes in the tree. The next N lines each contains the left and the right children of a node in the format left_index right_index, provided that the nodes are numbered from 0 to N−1, and 0 is always the root. If one child is missing, then −1 will represent the NULL child pointer. Finally N distinct integer keys are given in the last line.

Output Specification:
For each test case, print in one line the level order traversal sequence of that tree. All the numbers must be separated by a space, with no extra space at the end of the line.

Sample Input:
```
9
1 6
2 3
-1 -1
-1 4
5 -1
-1 -1
7 -1
-1 8
-1 -1
73 45 11 58 82 25 67 38 42
```
Sample Output:
```
58 25 82 11 38 67 45 73 42
```
题目大意：给出n个结点的二叉树的每个结点的左右孩子的编号，-1表示不存在，接着给出一个n个整数的序列，需要将这n个整数填入二叉树的结点中，使得二叉树成为一颗二叉查找树，输出这棵二叉查找树的层序遍历序列。

分析：采用二叉树的静态写法比较适合表示结点的编号关系，
对一颗二叉查找树来说，中序遍历序列是递增的，所以要把给定n个整数从小到大排序，然后对給定的二叉树进行中序遍历，同时将排序后的数字填入二叉树，最后层序遍历输出。
```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<algorithm>
using namespace std;
const int maxn = 110;
struct node {
    int data;
    int lchild, rchild;
}Node[maxn];
int n, in[maxn], num = 0;
void inorder(int root) {
    if(root == -1) {
        return ;
    }
    inorder(Node[root].lchild);
    Node[root].data = in[num++];
    inorder(Node[root].rchild);
}
void bfs(int root) {
    queue<int> q;
    q.push(root);
    num = 0;
    while(!q.empty()) {
        int now = q.front();
        q.pop();
        printf("%d", Node[now].data);
        num++;
        if(num < n) {
            printf(" ");
        }
        if(Node[now].lchild != -1) {
            q.push(Node[now].lchild);
        }
        if(Node[now].rchild != -1) {
            q.push(Node[now].rchild);
        }
    }
}
int main() {
    int lchild, rchild;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d%d", &lchild, &rchild);
        Node[i].lchild = lchild;
        Node[i].rchild = rchild;
    }
    for(int i = 0; i < n; i++) {
        scanf("%d", &in[i]);
    }
    sort(in, in + n);
    inorder(0);
    bfs(0);
    return 0;
}

```