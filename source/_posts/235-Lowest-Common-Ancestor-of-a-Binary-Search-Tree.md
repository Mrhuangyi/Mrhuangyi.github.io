---
title: 235. Lowest Common Ancestor of a Binary Search Tree
date: 2018-06-09 12:34:37
tags: LeetCode
categories: 题解集
---

Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

Given binary search tree:  root = [6,2,8,0,4,7,9,null,null,3,5]

        _______6______
       /              \
    ___2__          ___8__
   /      \        /      \
   0      _4       7       9
         /  \
         3   5
Example 1:

Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.
Example 2:

Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself 
             according to the LCA definition.
Note:

All of the nodes' values will be unique.
p and q are different and both values will exist in the BST.

LCA问题，题目要求你求出给定结点的最近公共祖先。
我们先来看下维基百科中关于LCA的定义：
在图论和计算机科学中，最近公共祖先（英语：lowest common ancestor）是指在一个树或者有向无环图中同时拥有v和w作为后代的最深的节点。在这里，我们定义一个节点也是其自己的后代，因此如果v是w的后代，那么w就是v和w的最近公共祖先。

最近公共祖先是两个节点所有公共祖先中离根节点最远的，计算最近公共祖先和根节点的长度往往是有用的。比如为了计算树中两个节点v和w之间的距离，可以使用以下方法：分别计算由v到根节点和w到根节点的距离，两者之和减去最近公共祖先到根节点的距离的两倍即可得到v到w的距离。

我们只需要遍历二叉搜索树，如果结点的值比p和q都要大，那么LCA肯定在该结点的左边，反之，如果结点的值比p和q都要小，那么LCA肯定在该结点的右边，如果都不是，那么root其实就是LCA了。

递归写法：
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
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if(root==NULL){
            return NULL;
        }
        if(root->val>p->val&&root->val>q->val){
            return lowestCommonAncestor(root->left,p,q);
        }
        if(root->val<p->val&&root->val<q->val){
            return lowestCommonAncestor(root->right,p,q);
        }
        return root;
    }
};
```
迭代写法：
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
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
       while(root!=NULL){
           if(root->val>p->val&&root->val>q->val){
               root=root->left;
           }
           else if(root->val<p->val&&root->val<q->val){
               root=root->right;
           }else{
               break;
           }
       }
        return root;
    }
};
```