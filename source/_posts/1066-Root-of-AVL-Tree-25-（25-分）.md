---
title: 1066 Root of AVL Tree (25)（25 分）
date: 2018-08-20 17:34:29
tags: PAT
categories: 题解集
---

1066 Root of AVL Tree (25)（25 分）
An AVL tree is a self-balancing binary search tree. In an AVL tree, the heights of the two child subtrees of any node differ by at most one; if at any time they differ by more than one, rebalancing is done to restore this property. Figures 1-4 illustrate the rotation rules.

  

  

Now given a sequence of insertions, you are supposed to tell the root of the resulting AVL tree.

Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer N (<=20) which is the total number of keys to be inserted. Then N distinct integer keys are given in the next line. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print the root of the resulting AVL tree in one line.

Sample Input 1:
```
5
88 70 61 96 120
```
Sample Output 1:
```
70
```
Sample Input 2:
```
7
88 70 61 96 120 90 65
```
Sample Output 2:
```
88
```
题目大意：给出n个整数，将他们依次插入一棵初始为空的AVL树上，求插入后根结点的值。
```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<algorithm>
using namespace std;
struct node {
    int v, height;
    node *lchild, *rchild;
}*root;
node* newnode(int v) {
    node* Node = new node;
    Node->v = v;
    Node->height = 1;
    Node->lchild = Node->rchild = NULL;
    return Node;
}
int getHeight(node* root) {
    if(root == NULL) {
        return 0;
    }
    return root->height;
}
void updatahegiht(node* root) {
    root->height = max(getHeight(root->lchild), getHeight(root->rchild)) + 1;
}
int getbalancefac(node* root) {
    return getHeight(root->lchild) - getHeight(root->rchild);
}
void L(node* &root) {
    node* temp = root->rchild;
    root->rchild = temp->lchild;
    temp->lchild = root;
    updatahegiht(root);
    updatahegiht(temp);
    root = temp;
}
void R(node* &root) {
    node* temp = root->lchild;
    root->lchild = temp->rchild;
    temp->rchild = root;
    updatahegiht(root);
    updatahegiht(temp);
    root = temp;
}
void insert(node* &root, int v) {
    if(root == NULL) {
        root = newnode(v);
        return ;
    }
    if(v < root->v) {
        insert(root->lchild, v);
        updatahegiht(root);
        if(getbalancefac(root) == 2) {
            if(getbalancefac(root->lchild) == 1) {
                R(root);
            } else if(getbalancefac(root->lchild) == -1) {
                L(root->lchild);
                R(root);
            }
        }
    } else {
        insert(root->rchild, v);
        updatahegiht(root);
        if(getbalancefac(root) == -2) {
            if(getbalancefac(root->rchild) == -1) {
                L(root);
            } else if(getbalancefac(root->rchild) == 1) {
                R(root->rchild);
                L(root);
            }
        }
    }
}
node* create(int data[], int n) {
    node* root = NULL;
    for(int i = 0; i < n; i++) {
        insert(root, data[i]);
    }
    return root;
}
int main() {
    int n, v;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &v);
        insert(root, v);
    }
    printf("%d\n", root->v);
    return 0;
}

```