---
title: 1006 Sign In and Sign Out (25)（25 分）
date: 2018-07-20 15:14:46
tags: PAT
categories: 题解集
---

1006 Sign In and Sign Out (25)（25 分）
At the beginning of every day, the first person who signs in the computer room will unlock the door, and the last one who signs out will lock the door. Given the records of signing in's and out's, you are supposed to find the ones who have unlocked and locked the door on that day.

Input Specification:

Each input file contains one test case. Each case contains the records for one day. The case starts with a positive integer M, which is the total number of records, followed by M lines, each in the format:

ID_number Sign_in_time Sign_out_time
where times are given in the format HH:MM:SS, and ID number is a string with no more than 15 characters.

Output Specification:

For each test case, output in one line the ID numbers of the persons who have unlocked and locked the door on that day. The two ID numbers must be separated by one space.

Note: It is guaranteed that the records are consistent. That is, the sign in time must be earlier than the sign out time for each person, and there are no two persons sign in or out at the same moment.

Sample Input:
```
3
CS301111 15:30:28 17:00:10
SC3021234 08:00:00 11:25:25
CS301133 21:45:00 21:58:40
```
Sample Output:
```
SC3021234 CS301133
```
题目大意：给出n个人的机房签到，签离记录，让你找出最早来开门和最晚离开关门的人。
分析：可以写一个比较时间大小的函数来判断早到晚到。

```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
using namespace std;
struct pNode {
    char id[20];
    int hh, mm, ss;
}temp, ans1, ans2;
bool cmp(pNode node1, pNode node2) {
    if(node1.hh != node2.hh) {
        return node1.hh > node2.hh;
    }
    if(node1.mm != node2.mm) {
        return node1.mm > node2.mm;
    }
    return node1.ss > node2.ss;
}
int main() {
    int n;
    scanf("%d", &n);
    ans1.hh = 24, ans1.mm = 60, ans1.ss = 60;
    ans2.hh = 0, ans2.mm = 0, ans2.ss = 0;
    for(int i = 0; i < n; i++) {
        scanf("%s %d:%d:%d", temp.id, &temp.hh, &temp.mm, &temp.ss);
        if(cmp(temp, ans1) == false) {
            ans1 = temp;
        }
        scanf("%d:%d:%d", &temp.hh, &temp.mm, &temp.ss);
        if(cmp(temp, ans2)) {
            ans2 = temp;
        }
    }
    printf("%s %s\n", ans1.id, ans2.id);
    return 0;
}

```