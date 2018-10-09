---
title: 1063 Set Similarity (25)（25 分）
date: 2018-08-02 22:10:05
tags: PAT
categories: 题解集
---

Given two sets of integers, the similarity of the sets is defined to be N~c~/N~t~*100%, where N~c~ is the number of distinct common numbers shared by the two sets, and N~t~ is the total number of distinct numbers in the two sets. Your job is to calculate the similarity of any given pair of sets.

Input Specification:

Each input file contains one test case. Each case first gives a positive integer N (<=50) which is the total number of sets. Then N lines follow, each gives a set with a positive M (<=10^4^) and followed by M integers in the range [0, 10^9^]. After the input of sets, a positive integer K (<=2000) is given, followed by K lines of queries. Each query gives a pair of set numbers (the sets are numbered from 1 to N). All the numbers in a line are separated by a space.

Output Specification:

For each query, print in one line the similarity of the sets, in the percentage form accurate up to 1 decimal place.

Sample Input:
```
3
3 99 87 101
4 87 101 5 87
7 99 101 18 5 135 18 99
2
1 2
1 3
```
Sample Output:
```
50.0%
33.3%
```
题目大意：给出n个集合，m个查询，每个查询给出两个集合的编号x，y，求集合x和集合y的相同元素率

```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<vector>
#include<algorithm>
#include<set>
using namespace std;
set<int> st[51];
void compare(int x, int y) {
    int num = st[y].size(), sameNum = 0;
    for(set<int>::iterator it = st[x].begin(); it != st[x].end(); it++) {
        if(st[y].find(*it) != st[y].end()) {
            sameNum++;
        } else {
            num++;
        }
    }
    printf("%.1f%%\n", sameNum * 100.0 / num);
}
int main() {
    int n, k, q, v, st1, st2;
    scanf("%d", &n);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &k);
        for(int j = 0; j < k; j++) {
            scanf("%d", &v);
            st[i].insert(v);
        }
    }
    scanf("%d", &q);
    for(int i = 0; i < q; i++) {
        scanf("%d%d", &st1, &st2);
        compare(st1, st2);
    }
    return 0;
}

```