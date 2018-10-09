---
title: 1054 The Dominant Color (20)（20 分）
date: 2018-08-02 22:21:36
tags: PAT
categories: 题解集
---

1054 The Dominant Color (20)（20 分）
Behind the scenes in the computer's memory, color is always talked about as a series of 24 bits of information for each pixel. In an image, the color with the largest proportional area is called the dominant color. A strictly dominant color takes more than half of the total area. Now given an image of resolution M by N (for example, 800x600), you are supposed to point out the strictly dominant color.

Input Specification:

Each input file contains one test case. For each case, the first line contains 2 positive numbers: M (<=800) and N (<=600) which are the resolutions of the image. Then N lines follow, each contains M digital colors in the range [0, 2^24^). It is guaranteed that the strictly dominant color exists for each input image. All the numbers in a line are separated by a space.

Output Specification:

For each test case, simply print the dominant color in a line.

Sample Input:
```
5 3
0 0 255 16777215 24
24 24 0 0 24
24 0 24 24 24
```
Sample Output:
```
24
```
题目大意: 给出一个n*m的数字矩阵，求其中超过半数的出现次数最多的数字

可以用map建立一个数字和该数字出现次数的映射关系
```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<vector>
#include<algorithm>
#include<set>
#include<map>
using namespace std;
int main() {
    int n, m, col;
    scanf("%d%d", &n, &m);
    map<int, int> count;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            scanf("%d", &col);
            if(count.find(col) != count.end()) {
                count[col]++;
            } else {
                count[col] = 1;
            }
        }
    }
    int k = 0, maxm = 0;
    for(map<int, int>::iterator it = count.begin(); it != count.end(); it++) {
        if(it->second > maxm) {
            k = it->first;
            maxm = it->second;
        }
    }
    printf("%d\n", k);
    return 0;
}

```