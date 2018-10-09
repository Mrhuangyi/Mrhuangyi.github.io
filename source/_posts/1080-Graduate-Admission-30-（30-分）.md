---
title: 1080 Graduate Admission (30)（30 分）
date: 2018-07-27 16:36:36
tags: PAT
categories: 题解集
---

It is said that in 2013, there were about 100 graduate schools ready to proceed over 40,000 applications in Zhejiang Province. It would help a lot if you could write a program to automate the admission procedure.

Each applicant will have to provide two grades: the national entrance exam grade G~E~, and the interview grade G~I~. The final grade of an applicant is (G~E~ + G~I~) / 2. The admission rules are:

The applicants are ranked according to their final grades, and will be admitted one by one from the top of the rank list.
If there is a tied final grade, the applicants will be ranked according to their national entrance exam grade G~E~. If still tied, their ranks must be the same.
Each applicant may have K choices and the admission will be done according to his/her choices: if according to the rank list, it is one's turn to be admitted; and if the quota of one's most preferred shcool is not exceeded, then one will be admitted to this school, or one's other choices will be considered one by one in order. If one gets rejected by all of preferred schools, then this unfortunate applicant will be rejected.
If there is a tied rank, and if the corresponding applicants are applying to the same school, then that school must admit all the applicants with the same rank, even if its quota will be exceeded.
Input Specification:

Each input file contains one test case. Each case starts with a line containing three positive integers: N (<=40,000), the total number of applicants; M (<=100), the total number of graduate schools; and K (<=5), the number of choices an applicant may have.

In the next line, separated by a space, there are M positive integers. The i-th integer is the quota of the i-th graduate school respectively.

Then N lines follow, each contains 2+K integers separated by a space. The first 2 integers are the applicant's G~E~ and G~I~, respectively. The next K integers represent the preferred schools. For the sake of simplicity, we assume that the schools are numbered from 0 to M-1, and the applicants are numbered from 0 to N-1.

Output Specification:

For each test case you should output the admission results for all the graduate schools. The results of each school must occupy a line, which contains the applicants' numbers that school admits. The numbers must be in increasing order and be separated by a space. There must be no extra space at the end of each line. If no applicant is admitted by a school, you must output an empty line correspondingly.

Sample Input:
```
11 6 3
2 1 2 2 2 3
100 100 0 1 2
60 60 2 3 5
100 90 0 3 4
90 100 1 2 0
90 90 5 1 3
80 90 1 0 2
80 80 0 1 2
80 80 0 1 2
80 70 1 3 2
70 80 1 2 3
100 100 0 2 4
```
Sample Output:
```
0 10
3
5 6 7
2 8

1 4
```
题目大意：要求模拟学校录取招生的过程，按从小到大输出每个学校录取的考生编号

思路：
1. 分别定义学生和学校结构体存放对应信息
2. 对读入的所有考生进行排序，并按规则计算出各考生的排名
3. 对每个考生的每个志愿学校，如果当前志愿学校的招生人数未达到该校招生人数总额度或该校上一个录取考生的排名与该考生排名相同，则照样可以被录取。
4. 对每个学校将其按考生编号从小到大排序，并按顺序输出录取考生的编号。
```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
const int maxn = 40010;
struct Student{
    int GE, GI, sum;
    int r, stuID;
    int cho[6];
}stu[maxn];
struct School {
    int quota;
    int stuNum;
    int id[maxn];
    int lastAdmit;
}sch[111];
bool cmpStu(Student a, Student b) {
    if(a.sum != b.sum) {
        return a.sum > b.sum;
    } else {
       return a.GE > b.GE;
    }
}
bool cmpId(int a, int b) {
    return stu[a].stuID < stu[b].stuID;
}
int main() {
    int n, m, k;
    scanf("%d %d %d", &n, &m, &k);
    for(int i = 0; i < m; i++) {
        scanf("%d", &sch[i].quota);
        sch[i].stuNum = 0;
        sch[i].lastAdmit = -1;
    }
    for(int i = 0; i < n; i++) {
        stu[i].stuID = i;
        scanf("%d%d", &stu[i].GE, &stu[i].GI);
        stu[i].sum = stu[i].GE + stu[i].GI;
        for(int j = 0; j < k; j++) {
            scanf("%d", &stu[i].cho[j]);
        }
    }
    sort(stu, stu + n, cmpStu);
    for(int i = 0; i < n; i++) {
        if(i > 0 && stu[i].sum == stu[i - 1].sum && stu[i].GE == stu[i - 1].GE) {
            stu[i].r = stu[i - 1].r;
        } else {
            stu[i].r = i;
        }
    }
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < k; j++) {
            int choice = stu[i].cho[j];
            int num = sch[choice].stuNum;
            int last = sch[choice].lastAdmit;
            if(num < sch[choice].quota || (last != -1 && stu[i].r == stu[last].r)) {
                sch[choice].id[num] = i;
                sch[choice].lastAdmit = i;
                sch[choice].stuNum++;
                break;
            }
        }
    }
    for(int i = 0; i < m; i++) {
        if(sch[i].stuNum > 0) {
            sort(sch[i].id, sch[i].id + sch[i].stuNum, cmpId);
            for(int j = 0; j < sch[i].stuNum; j++) {
                printf("%d", stu[sch[i].id[j]].stuID);
                if(j < sch[i].stuNum - 1) {
                    printf(" ");
                }
            }
        }
        printf("\n");
    }
    return 0;
}

```