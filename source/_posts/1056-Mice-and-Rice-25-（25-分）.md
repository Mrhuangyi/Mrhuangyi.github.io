---
title: 1056 Mice and Rice (25)（25 分）
date: 2018-08-12 12:21:54
tags: PAT
categories: 题解集
---

1056 Mice and Rice (25)（25 分）
Mice and Rice is the name of a programming contest in which each programmer must write a piece of code to control the movements of a mouse in a given map. The goal of each mouse is to eat as much rice as possible in order to become a FatMouse.

First the playing order is randomly decided for N~P~ programmers. Then every N~G~ programmers are grouped in a match. The fattest mouse in a group wins and enters the next turn. All the losers in this turn are ranked the same. Every N~G~ winners are then grouped in the next match until a final winner is determined.

For the sake of simplicity, assume that the weight of each mouse is fixed once the programmer submits his/her code. Given the weights of all the mice and the initial playing order, you are supposed to output the ranks for the programmers.

Input Specification:

Each input file contains one test case. For each case, the first line contains 2 positive integers: N~P~ and N~G~ (<= 1000), the number of programmers and the maximum number of mice in a group, respectively. If there are less than N~G~ mice at the end of the player's list, then all the mice left will be put into the last group. The second line contains N~P~ distinct non-negative numbers W~i~ (i=0,...N~P~-1) where each W~i~ is the weight of the i-th mouse respectively. The third line gives the initial playing order which is a permutation of 0,...N~P~-1 (assume that the programmers are numbered from 0 to N~P~-1). All the numbers in a line are separated by a space.

Output Specification:

For each test case, print the final ranks in a line. The i-th number is the rank of the i-th programmer, and all the numbers must be separated by a space, with no extra space at the end of the line.

Sample Input:
```
11 3
25 18 0 46 37 3 19 22 57 56 10
6 0 8 7 10 5 9 1 4 2 3
```
Sample Output:
```
5 5 5 2 5 5 5 3 1 3 5
```
题目大意:给出np只老鼠的质量，并给出他们的初始顺序，按这个顺序把这些老鼠按每ng只分为一组，最后不够ng只的也单独分为一组。对每一组老鼠选出其中质量最大的晋级，晋级的老树数就等于该轮分组的组数。重复上述步骤，最后把这些老鼠的排名按原输入的顺序输出。


```cpp
#include<iostream>
#include<cstdio>
#include<string>
#include<queue>
using namespace std;
const int maxn = 1010;
struct mouse {
    int weight;
    int rank;
}mouse[maxn];
int main() {
    int np, ng, order;
    scanf("%d%d", &np, &ng);
    for(int i = 0; i < np; i++) {
        scanf("%d", &mouse[i].weight);
    }
    queue<int> q;
    for(int i = 0; i < np; i++) {
        scanf("%d", &order);
        q.push(order);
    }
    int temp = np, group;
    while(q.size() != 1) {
        if(temp % ng == 0) {
            group = temp / ng;
        } else {
            group = temp / ng + 1;
        }
        for(int i = 0; i < group; i++) {
            int k = q.front();
            for(int j = 0; j < ng; j++) {
                if(i * ng + j >= temp) {
                    break;
                }
                int front = q.front();
                if(mouse[front].weight >= mouse[k].weight) {
                    k = front;
                }
                mouse[front].rank = group + 1;
                q.pop();
            }
            q.push(k);
        }
        temp = group;
    }
    mouse[q.front()].rank = 1;
    for(int i = 0; i < np; i++) {
        printf("%d", mouse[i].rank);
        if(i < np - 1) {
            printf(" ");
        }
    }
    return 0;
}

```