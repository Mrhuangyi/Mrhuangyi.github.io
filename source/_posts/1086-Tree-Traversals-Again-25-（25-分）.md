---
title: 1086 Tree Traversals Again (25)（25 分）
date: 2018-08-13 15:30:06
tags: PAT
categories: 题解集
---

1086 Tree Traversals Again (25)（25 分）
An inorder binary tree traversal can be implemented in a non-recursive way with a stack. For example, suppose that when a 6-node binary tree (with the keys numbered from 1 to 6) is traversed, the stack operations are: push(1); push(2); push(3); pop(); pop(); push(4); pop(); pop(); push(5); push(6); pop(); pop(). Then a unique binary tree (shown in Figure 1) can be generated from this sequence of operations. Your task is to give the postorder traversal sequence of this tree.

\ Figure 1

Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer N (<=30) which is the total number of nodes in a tree (and hence the nodes are numbered from 1 to N). Then 2N lines follow, each describes a stack operation in the format: "Push X" where X is the index of the node being pushed onto the stack; or "Pop" meaning to pop one node from the stack.

Output Specification:

For each test case, print the postorder traversal sequence of the corresponding tree in one line. A solution is guaranteed to exist. All the numbers must be separated by exactly one space, and there must be no extra space at the end of the line.

Sample Input:
```
6
Push 1
Push 2
Push 3
Pop
Pop
Push 4
Pop
Pop
Push 5
Push 6
Pop
Pop
```
Sample Output:
```
3 4 2 6 5 1
```

题目大意：用栈来模拟一棵二叉树的先序和中序遍历，求这棵二叉树的后序遍历序列，
思路：
每次访问一个结点就把它入栈，类似先序遍历先访问根结点，所以push的次序就是先序遍历序列中元素的顺序，pop是按照左子树，根结点，右子树的顺序进行，所以pop的次序就是中序遍历序列中的元素顺序。
所以就是要根据二叉树的先序遍历序列和中序遍历序列，重构二叉树然后进行后序遍历
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
const int maxn = 50;
struct node {
    int data;
    node* lchild;
    node* rchild;
};
int pre[maxn], in[maxn], post[maxn];
int n;
node* create(int preL, int preR, int inL, int inR) {
    if(preL > preR) {
        return NULL;
    }
    node* root = new node;
    root->data = pre[preL];
    int k;
    for(k = inL; k <= inR; k++) {
        if(in[k] == pre[preL]) {
            break;
        }
    }
    int numLeft = k - inL;
    root->lchild = create(preL + 1, preL + numLeft, inL, k - 1);
    root->rchild = create(preL + numLeft + 1, preR, k + 1, inR);
    return root;
}
int num = 0;
void postorder(node* root) {
    if(root == NULL) {
        return;
    }
    postorder(root->lchild);
    postorder(root->rchild);
    printf("%d", root->data);
    num++;
    if(num < n) {
        printf(" ");
    }
}
int main()
{
    scanf("%d", &n);
    char str[5];
    stack<int> st;
    int x, preIndex = 0, inIndex = 0;
    for(int i = 0; i < 2 * n; i++) {
        scanf("%s", str);
        if(strcmp(str, "Push") == 0) {
            scanf("%d", &x);
            pre[preIndex++] = x;
            st.push(x);
        } else {
            in[inIndex++] = st.top();
            st.pop();
        }
    }
    node* root = create(0, n - 1, 0, n - 1);
    postorder(root);
    return 0;
}

```