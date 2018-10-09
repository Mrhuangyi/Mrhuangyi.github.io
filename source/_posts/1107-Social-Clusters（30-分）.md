---
title: 1107 Social Clusters（30 分）
date: 2018-08-20 17:52:35
tags: PAT
categories: 题解集
---

1107 Social Clusters（30 分）
When register on a social network, you are always asked to specify your hobbies in order to find some potential friends with the same hobbies. A social cluster is a set of people who have some of their hobbies in common. You are supposed to find all the clusters.

Input Specification:
Each input file contains one test case. For each test case, the first line contains a positive integer N (≤1000), the total number of people in a social network. Hence the people are numbered from 1 to N. Then N lines follow, each gives the hobby list of a person in the format:

K
​i
​​ : h
​i
​​ [1] h
​i
​​ [2] ... h
​i
​​ [K
​i
​​ ]

where K
​i
​​  (>0) is the number of hobbies, and h
​i
​​ [j] is the index of the j-th hobby, which is an integer in [1, 1000].

Output Specification:
For each case, print in one line the total number of clusters in the network. Then in the second line, print the numbers of people in the clusters in non-increasing order. The numbers must be separated by exactly one space, and there must be no extra space at the end of the line.

Sample Input:
```
8
3: 2 7 10
1: 4
2: 5 3
1: 4
1: 3
1: 4
4: 6 8 1 5
1: 4
```
Sample Output:
```
3
4 3 1
```

题目大意：如果有两个人有任意一个活动相同，那么救称他们处于同一个社交网络，给定n个人，求n个人形成了多少社交网络。
用course[h]记录喜欢活动h的人的编号，那么findFather(course[h])就是这个人所在的社交网络的根结点，合并当前读入的编号i与findFather(course[h])
集合计数可以开一个isRoot数组表示x号人作为根结点的社交网络中有多少人
```cpp
#include<iostream>
#include<cstdio>
#include<queue>
#include<algorithm>
using namespace std;
const int maxn = 1010;
int father[maxn];
int isRoot[maxn] = {0};
int course[maxn] = {0};
int findFather(int x) {
    int a = x;
    while(x != father[x]) {
        x = father[x];
    }
    while(a != father[a]) {
        int z = a;
        a = father[a];
        father[z] = x;
    }
    return x;
}
void Union(int a, int b) {
    int faA = findFather(a);
    int faB = findFather(b);
    if(faA != faB) {
        father[faA] = faB;
    }
}
void init(int n) {
    for(int i = 1; i <= n; i++) {
        father[i] = i;
        isRoot[i] = false;
    }
}
bool cmp(int a, int b) {
    return a > b;
}
int main() {
    int n, k, h;
    scanf("%d", &n);
    init(n);
    for(int i = 1; i <= n; i++) {
        scanf("%d:", &k);
        for(int j = 0; j < k; j++) {
            scanf("%d", &h);
            if(course[h] == 0) {
                course[h] = i;
            }
            Union(i, findFather(course[h]));
        }
    }
    for(int i = 1; i <= n; i++) {
        isRoot[findFather(i)]++;
    }
    int ans = 0;
    for(int i = 1; i <= n; i++) {
        if(isRoot[i] != 0) {
            ans++;
        }
    }
    printf("%d\n", ans);
    sort(isRoot + 1, isRoot + n + 1, cmp);
    for(int i = 1; i <= ans; i++) {
        printf("%d", isRoot[i]);
        if(i < ans) {
            printf(" ");
        }
    }
    return 0;
}

```