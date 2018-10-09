---
title: 1051 Pop Sequence (25)（25 分）
date: 2018-08-10 15:22:38
tags: PAT
categories: 题解集
---

1051 Pop Sequence (25)（25 分）
Given a stack which can keep M numbers at most. Push N numbers in the order of 1, 2, 3, ..., N and pop randomly. You are supposed to tell if a given sequence of numbers is a possible pop sequence of the stack. For example, if M is 5 and N is 7, we can obtain 1, 2, 3, 4, 5, 6, 7 from the stack, but not 3, 2, 1, 7, 5, 6, 4.

Input Specification:

Each input file contains one test case. For each case, the first line contains 3 numbers (all no more than 1000): M (the maximum capacity of the stack), N (the length of push sequence), and K (the number of pop sequences to be checked). Then K lines follow, each contains a pop sequence of N numbers. All the numbers in a line are separated by a space.

Output Specification:

For each pop sequence, print in one line "YES" if it is indeed a possible pop sequence of the stack, or "NO" if not.

Sample Input:
```
5 7 5
1 2 3 4 5 6 7
3 2 1 7 5 6 4
7 6 5 4 3 2 1
5 6 4 3 7 2 1
1 7 6 5 4 3 2
```
Sample Output:
```
YES
NO
NO
YES
NO
```
题目大意：
给定一个容量为m的栈，先分别把1，2，3...n依次入栈，并给出一系列出栈顺序，问这些出栈顺序是否可能。

```cpp
#include<iostream>
#include<string>
#include<map>
#include<set>
#include<cstdio>
#include<stack>
using namespace std;
const int maxn = 1010;
int arr[maxn];
stack<int> st;
int main() {
    int m, n, t;
    scanf("%d%d%d", &m, &n, &t);
    while(t--) {
        while(!st.empty()) {
            st.pop();
        }
        for(int i = 1; i <= n; i++) {
            scanf("%d", &arr[i]);
        }
        int cur = 1;
        bool flag = true;
        for(int i = 1; i <= n; i++) {
            st.push(i);
            if(st.size() > m) {
                flag = false;
                break;
            }
            while(!st.empty() && st.top() == arr[cur]) {
                st.pop();
                cur++;
            }
        }
        if(st.empty() == true && flag == true) {
            printf("YES\n");
        } else {
            printf("NO\n");
        }
    }
    return 0;
}

```