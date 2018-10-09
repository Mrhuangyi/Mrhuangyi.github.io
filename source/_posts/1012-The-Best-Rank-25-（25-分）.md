---
title: 1012 The Best Rank (25)（25 分）
date: 2018-07-23 10:09:50
tags: PAT
categories: 题解集
---

1012 The Best Rank (25)（25 分）
To evaluate the performance of our first year CS majored students, we consider their grades of three courses only: C - C Programming Language, M - Mathematics (Calculus or Linear Algebra), and E - English. At the mean time, we encourage students by emphasizing on their best ranks -- that is, among the four ranks with respect to the three courses and the average grade, we print the best rank for each student.

For example, The grades of C, M, E and A - Average of 4 students are given as the following:
```
StudentID  C  M  E  A
310101     98 85 88 90
310102     70 95 88 84
310103     82 87 94 88
310104     91 91 91 91
```
Then the best ranks for all the students are No.1 since the 1st one has done the best in C Programming Language, while the 2nd one in Mathematics, the 3rd one in English, and the last one in average.

Input

Each input file contains one test case. Each case starts with a line containing 2 numbers N and M (<=2000), which are the total number of students, and the number of students who would check their ranks, respectively. Then N lines follow, each contains a student ID which is a string of 6 digits, followed by the three integer grades (in the range of [0, 100]) of that student in the order of C, M and E. Then there are M lines, each containing a student ID.

Output

For each of the M students, print in one line the best rank for him/her, and the symbol of the corresponding rank, separated by a space.

The priorities of the ranking methods are ordered as A > C > M > E. Hence if there are two or more ways for a student to obtain the same best rank, output the one with the highest priority.

If a student is not on the grading list, simply output "N/A".

Sample Input
```
5 6
310101 98 85 88
310102 70 95 88
310103 82 87 94
310104 91 91 91
310105 85 90 90
310101
310102
310103
310104
310105
999999
```
Sample Output
```
1 C
1 M
1 E
1 A
3 A
N/A
```
题目大意：已知n个学生的3门课分数C、M、E，以及这三门课的平均分A。
现在分别按这四个分数对n个考生从高到低排序，这样每个考生就有4个排名且每个分数都有一个排名。接下来有m个查询，输出该考生4个排名中最高的那个排名及对应的分数是哪个。如果不同课程有相同排名，则按优先级A>C>M>E输出，如果查询的考生id不存在，输出N/A

- 排名时注意相同的分数排名相同的。

```cpp
#include<iostream>
#include<cstdio>
#include<cmath>
#include<algorithm>
using namespace std;

struct Student {
    int id;
    int grade[4];
}stu[2001];

char course[4] = {'A', 'C', 'M', 'E'};
int Rank[1000000][4] = {0};
int now;

bool cmp(Student a, Student b) {
    return a.grade[now] > b.grade[now];
}

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    for(int i = 0; i < n; i++) {
        scanf("%d %d %d %d", &stu[i].id, &stu[i].grade[1], &stu[i].grade[2], &stu[i].grade[3]);
        stu[i].grade[0] = round((stu[i].grade[1] + stu[i].grade[2] + stu[i].grade[3]) / 3.0) + 0.5;
    }
    for(now = 0; now < 4; now++) {
        sort(stu, stu + n, cmp);
        Rank[stu[0].id][now] = 1;
        for(int i = 1; i < n; i++) {
            if(stu[i].grade[now] == stu[i - 1].grade[now]) {
                Rank[stu[i].id][now] = Rank[stu[i - 1].id][now];
            } else {
                Rank[stu[i].id][now] = i + 1;
            }
        }
    }
    int query;
    for(int i = 0; i < m; i++) {
        scanf("%d", &query);
        if(Rank[query][0] == 0) {
            printf("N/A\n");
        } else {
            int k = 0;
            for(int j = 0; j < 4; j++) {
                if(Rank[query][j] < Rank[query][k]) {
                    k = j;
                }
            }
            printf("%d %c\n", Rank[query][k], course[k]);
        }
    }
    return 0;
}

```