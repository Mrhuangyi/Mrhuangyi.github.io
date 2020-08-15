---
title: 腾讯精选50题LeetCode104. 二叉树的最大深度
date: 2017-08-13 13:40:30
categories: 题解集
tags: LeetCode
---

# 题目描述

给定一个二叉树，找出其最大深度。

二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

说明: 叶子节点是指没有子节点的节点。

示例：
```
给定二叉树 [3,9,20,null,null,15,7]，

    3
   / \
  9  20
    /  \
   15   7
返回它的最大深度 3 。
```

# 解题思路

我们借助递归来求：
递归边界为：root为NULL，那么返回0
在递归函数中分别定义结点左右子树的高度：
left = maxDepth(root->left);
right = maxDepth(root->right);
最后返回：max(left, right) + 1;
求出最大深度



# 具体代码

```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    int maxDepth(TreeNode* root) {
        if(root==NULL)
            return 0;
        return max(maxDepth(root->left),maxDepth(root->right))+1;
    }
};
```
