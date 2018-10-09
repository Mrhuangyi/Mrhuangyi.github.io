---
title: 653. 两数之和 IV - 输入 BST
date: 2018-07-19 17:49:39
tags: LeetCode
categories: 题解集
---

给定一个二叉搜索树和一个目标结果，如果 BST 中存在两个元素且它们的和等于给定的目标结果，则返回 true。

案例 1:
```
输入: 
    5
   / \
  3   6
 / \   \
2   4   7

Target = 9

输出: True
``` 

案例 2:
```
输入: 
    5
   / \
  3   6
 / \   \
2   4   7

Target = 28

输出: False
```
分析：又是两数之和的问题，可以借助set进行判断，还是哈希思想，遍历整个树，查找是否有符合条件的值。

递归写法：
递归写法要主要set的定义不能在函数内部进行。
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
     unordered_set<int> s;
    bool findTarget(TreeNode* root, int k) {
        if(root == NULL) {
            return false;
        }
        if(s.count(k - root->val) != 0) {
            return true;
        }
        s.insert(root->val);
        return findTarget(root->left, k) || findTarget(root->right, k);
    }
};
```

迭代写法：
迭代写法怎么写其实就看你准备怎么遍历二叉树了。

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
    bool findTarget(TreeNode* root, int k) {
        if(root == NULL) {
            return false;
        }
        unordered_set<int> s;
        queue<TreeNode* > q;
        q.push(root);
        while(!q.empty()) {
            TreeNode* t = q.front();
            q.pop();
            if(s.count(k - t->val)) {
                return true;
            }
            s.insert(t->val);
            if(t->left) {
                q.push(t->left);
            }
            if(t->right) {
                q.push(t->right);
            }
        }
        return false;
    }
};
```

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
    bool findTarget(TreeNode* root, int k) {
        if(root == NULL) {
            return false;
        }
        unordered_set<int> s;
        stack<TreeNode* > st;
        while(!st.empty() || root != NULL) {
            if(root != NULL) {
                if(s.count(root->val)) {
                    return true;
                } else {
                    s.insert(k - root->val);
                }
                st.push(root);
                root = root->left;
            } else {
                TreeNode *node = st.top();
                st.pop();
                root = node->right;
            }
        }
        return false;
    }
};
```