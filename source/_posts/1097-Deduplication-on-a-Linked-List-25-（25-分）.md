---
title: 1097 Deduplication on a Linked List (25)（25 分）
date: 2018-08-12 12:45:58
tags: PAT
categories: 题解集
---

1097 Deduplication on a Linked List (25)（25 分）
Given a singly linked list L with integer keys, you are supposed to remove the nodes with duplicated absolute values of the keys. That is, for each value K, only the first node of which the value or absolute value of its key equals K will be kept. At the mean time, all the removed nodes must be kept in a separate list. For example, given L being 21→-15→-15→-7→15, you must output 21→-15→-7, and the removed list -15→15.

Input Specification:

Each input file contains one test case. For each case, the first line contains the address of the first node, and a positive N (<= 10^5^) which is the total number of nodes. The address of a node is a 5-digit nonnegative integer, and NULL is represented by -1.

Then N lines follow, each describes a node in the format:

Address Key Next

where Address is the position of the node, Key is an integer of which absolute value is no more than 10^4^, and Next is the position of the next node.

Output Specification:

For each case, output the resulting linked list first, then the removed list. Each node occupies a line, and is printed in the same format as in the input.

Sample Input:
```
00100 5
99999 -7 87654
23854 -15 00000
87654 15 -1
00000 -15 99999
00100 21 23854
```
Sample Output:
```
00100 21 23854
23854 -15 99999
99999 -7 -1
00000 -15 87654
87654 15 -1
```
题目大意：给出n个结点的地址，数据域和指针域，然后给出链表的首地址，要求去除链表上的权值的绝对值相同的结点只保留第一个结点，然后把未删除的结点按链表连接顺序输出，接着把被删除的结点也按在原链表的顺序输出。


```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<queue>
#include<algorithm>
using namespace std;
const int maxn = 100005;
const int table = 1000010;
struct Node {
    int address, data, next;
    int order;
}node[maxn];
bool isExist[table] = {false};
bool cmp(Node a, Node b) {
    return a.order < b.order;
}
int main() {
    memset(isExist, false, sizeof(isExist));
    for(int i = 0; i < maxn; i++) {
        node[i].order = 2 * maxn;
    }
    int n, begin, address;
    scanf("%d%d", &begin, &n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &address);
        scanf("%d%d", &node[address].data, &node[address].next);
        node[address].address = address;
    }
    int countValid = 0, countRemoved = 0, p = begin;
    while(p != -1) {
        if(!isExist[abs(node[p].data)]) {
            isExist[abs(node[p].data)] = true;
            node[p].order = countValid++;
        } else {
            node[p].order = maxn + countRemoved++;
        }
        p = node[p].next;
    }
    sort(node, node + maxn, cmp);
    int count = countValid + countRemoved;
    for(int i = 0; i < count; i++) {
        if(i != countValid - 1 && i != count - 1) {
            printf("%05d %d %05d\n",node[i].address, node[i].data, node[i + 1].address);
        } else {
            printf("%05d %d -1\n", node[i].address, node[i].data);
        }
    }
    return 0;
}

```
