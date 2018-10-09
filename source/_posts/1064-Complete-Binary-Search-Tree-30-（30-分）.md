---
title: 1064 Complete Binary Search Tree (30)（30 分）
date: 2018-08-19 16:02:25
tags: PAT
categories: 题解集
---

1064 Complete Binary Search Tree (30)（30 分）
A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
Both the left and right subtrees must also be binary search trees.
A Complete Binary Tree (CBT) is a tree that is completely filled, with the possible exception of the bottom level, which is filled from left to right.

Now given a sequence of distinct non-negative integer keys, a unique BST can be constructed if it is required that the tree must also be a CBT. You are supposed to output the level order traversal sequence of this BST.

Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer N (<=1000). Then N distinct non-negative integer keys are given in the next line. All the numbers in a line are separated by a space and are no greater than 2000.

Output Specification:

For each test case, print in one line the level order traversal sequence of the corresponding complete binary search tree. All the numbers in a line must be separated by a space, and there must be no extra space at the end of the line.

Sample Input:
```
10
1 2 3 4 5 6 7 8 9 0
```
Sample Output:
```
6 3 8 1 5 7 9 0 2 4
```
题目大意：给出n个非负整数，用他们构建一棵完全二叉排序树，输出这棵树的层序遍历序列。
分析：用数组在存放完全二叉树，对完全二叉树中的任意一个节点x，其左孩子结点的编号为2x，右孩子编号为2x+1
对一颗二叉排序树来说，其中序遍历序列是递增的，所以先将给定数字从小到大排序，然后对cbt数组表示的二叉树进行中序遍历，并再遍历过程中将数字从小到大填入数组
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
const int maxn = 1010;
int n, number[maxn], cbt[maxn], index = 0;
void inorder(int root) {
    if(root > n) {
        return ;
    }
    inorder(root * 2);
    cbt[root] = number[index++];
    inorder(root * 2 + 1);
}
int main()
{
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &number[i]);
    }
    sort(number, number + n);
    inorder(1);
    for(int i = 1; i <= n; i++) {
        printf("%d", cbt[i]);
        if(i < n) {
            printf(" ");
        }
    }
    return 0;
}

```