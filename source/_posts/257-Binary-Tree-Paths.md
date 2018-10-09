---
title: 257. Binary Tree Paths
date: 2018-06-08 13:07:30
tags: LeetCode
categories: 题解集
---

Given a binary tree, return all root-to-leaf paths.

Note: A leaf is a node with no children.

Example:

Input:

   1
 /   \
2     3
 \
  5

Output: ["1->2->5", "1->3"]

Explanation: All root-to-leaf paths are: 1->2->5, 1->3

题目要求：给定一棵二叉树，返回所有从根结点到叶结点的路径

分析：采用深度优先搜索，递归访问每个结点的子结点，如果遇到叶结点，则输出所记录的路径。然后返回上一层

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
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> result;
        if(root==nullptr){
            return result;
        }
        vector<int> path;
        dfs(root,path,result);
        return result;
    }
private: 
    void dfs(TreeNode* node,vector<int>& path,vector<string>& result){
        if(node==nullptr){
            return ;
        }
        path.push_back(node->val);
        if(node->left==nullptr&&node->right==nullptr){
            result.push_back(generatePath(path));
        }else{
            if(node->left!=nullptr){
                dfs(node->left,path,result);
                path.pop_back();
            }
            if(node->right!=nullptr){
                dfs(node->right,path,result);
                path.pop_back();
            }
        }
    }
    string generatePath(vector<int> path){
        stringstream ss;
        int i;
        for(i=0;i<path.size()-1;i++){
            ss<<path[i]<<"->";
            
        }
        ss<<path[i];
        return ss.str();
    }
};
```