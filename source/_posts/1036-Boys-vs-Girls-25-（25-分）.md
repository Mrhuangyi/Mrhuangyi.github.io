---
title: 1036 Boys vs Girls (25)（25 分）
date: 2018-07-20 15:31:15
tags: PAT
categories: 题解集
---

1036 Boys vs Girls (25)（25 分）
This time you are asked to tell the difference between the lowest grade of all the male students and the highest grade of all the female students.

Input Specification:

Each input file contains one test case. Each case contains a positive integer N, followed by N lines of student information. Each line contains a student's name, gender, ID and grade, separated by a space, where name and ID are strings of no more than 10 characters with no space, gender is either F (female) or M (male), and grade is an integer between 0 and 100. It is guaranteed that all the grades are distinct.

Output Specification:

For each test case, output in 3 lines. The first line gives the name and ID of the female student with the highest grade, and the second line gives that of the male student with the lowest grade. The third line gives the difference grade~F~-grade~M~. If one such kind of student is missing, output "Absent" in the corresponding line, and output "NA" in the third line instead.

Sample Input 1:
```
3
Joe M Math990112 89
Mike M CS991301 100
Mary F EE990830 95
```
Sample Output 1:
```
Mary EE990830
Joe Math990112
6
```
Sample Input 2:
```
1
Jean M AA980920 60
Sample Output 2:
```
```
Absent
Jean AA980920
NA
```
题目大意：给出n个同学的信息，输出女生中最高分获得者的信息和男生中最低分获得者的信息，并输出他们的差。如果不存在男生或女生在对应位置输出Absent，在分数差的位置输出NA
```cpp
#include<cstdio>
struct person {
    char name[15];
    char id[15];
    int score;
}male, female, temp;
void init() {
    male.score = 101;
    female.score = -1;
}
int main() {
    init();
    int n;
    char gender;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%s %c %s %d", temp.name, &gender, &temp.id, &temp.score);
        if(gender == 'M' && temp.score < male.score) {
            male = temp;
        } else if(gender == 'F' && temp.score > female.score) {
            female = temp;
        }
    }
    if(female.score == -1) {
        printf("Absent\n");
    } else {
        printf("%s %s\n", female.name, female.id);
    }
    if(male.score == 101) {
        printf("Absent\n");
    } else {
        printf("%s %s\n", male.name, male.id);
    }
    if(female.score == -1 || male.score == 101) {
        printf("NA\n");
    } else {
        printf("%d\n", female.score - male.score);
    }
    return 0;
}

```