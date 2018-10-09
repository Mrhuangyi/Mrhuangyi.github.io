---
title: 1042 Shuffling Machine (20)（20 分）
date: 2018-07-19 13:15:19
tags: PAT
categories: 题解集
---

1042 Shuffling Machine (20)（20 分）
Shuffling is a procedure used to randomize a deck of playing cards. Because standard shuffling techniques are seen as weak, and in order to avoid "inside jobs" where employees collaborate with gamblers by performing inadequate shuffles, many casinos employ automatic shuffling machines. Your task is to simulate a shuffling machine.

The machine shuffles a deck of 54 cards according to a given random order and repeats for a given number of times. It is assumed that the initial status of a card deck is in the following order:

S1, S2, ..., S13, H1, H2, ..., H13, C1, C2, ..., C13, D1, D2, ..., D13, J1, J2

where "S" stands for "Spade", "H" for "Heart", "C" for "Club", "D" for "Diamond", and "J" for "Joker". A given order is a permutation of distinct integers in [1, 54]. If the number at the i-th position is j, it means to move the card from position i to position j. For example, suppose we only have 5 cards: S3, H5, C1, D13 and J2. Given a shuffling order {4, 2, 5, 3, 1}, the result will be: J2, H5, D13, S3, C1. If we are to repeat the shuffling again, the result will be: C1, H5, S3, J2, D13.

Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer K (<= 20) which is the number of repeat times. Then the next line contains the given order. All the numbers in a line are separated by a space.

Output Specification:

For each test case, print the shuffling results in one line. All the cards are separated by a space, and there must be no extra space at the end of the line.

Sample Input:
```
2
36 52 37 38 3 39 40 53 54 41 11 12 13 42 43 44 2 4 23 24 25 26 27 6 7 8 48 49 50 51 9 10 14 15 16 5 17 18 19 1 20 21 22 28 29 30 31 32 33 34 35 45 46 47
```
Sample Output:
```
S7 C11 C10 C12 S1 H7 H8 H9 D8 D9 S11 S12 S13 D10 D11 D12 S3 S4 S6 S10 H1 H2 C13 D2 D3 D4 H6 H3 D13 J1 J2 C1 C2 C3 C4 D1 S5 H5 H11 H12 C6 C7 C8 C9 S2 S8 S9 H10 D5 D6 D7 H4 H13 C5
```

题目大意：有54张牌，编号为1~54，初始按编号从小到大排列。这些牌按初始排列给定花色，从左到右为13张S，13张H，13张C，13张D，2张J，接下来执行一操作，将牌的位置改变为指定位置，这样的操作执行k次。求最好的排列结果。

分析：可以开两个数组，star与end，分别用来存放每次执行操作前的牌序和执行操作后的牌序。使用char数组来建立编号与花色的关系。

```cpp
#include<cstdio>
#include<iostream>
#include<vector>
#include<map>
using namespace std;
const int N = 54;
char mp[5] = {'S', 'H', 'C', 'D', 'J'};
int main()
{
    int k;
    int next[55], start[55], end[55];;
    scanf("%d", &k);
    for(int i = 1; i <= N; i++) {
        start[i] = i;
    }
    for(int i = 1;i <= N; i++) {
        scanf("%d", &next[i]);
    }
    for(int step = 0; step < k; step++) {
        for(int i = 1; i <= N; i++) {
            end[next[i]] = start[i];
        }
        for(int i = 1; i <= N; i++) {
            start[i] = end[i];
        }
    }
    for(int i = 1; i <= N; i++) {
        if(i != 1) {
            printf(" ");
        }
        start[i]--;
        printf("%c%d",mp[start[i] / 13], start[i] % 13 + 1);
    }
    return 0;
}

```