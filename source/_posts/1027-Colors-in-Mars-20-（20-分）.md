---
title: 1027 Colors in Mars (20)（20 分）
date: 2018-07-21 14:01:07
tags: PAT
categories: 题解集
---

1027 Colors in Mars (20)（20 分）
People in Mars represent the colors in their computers in a similar way as the Earth people. That is, a color is represented by a 6-digit number, where the first 2 digits are for Red, the middle 2 digits for Green, and the last 2 digits for Blue. The only difference is that they use radix 13 (0-9 and A-C) instead of 16. Now given a color in three decimal numbers (each between 0 and 168), you are supposed to output their Mars RGB values.

Input

Each input file contains one test case which occupies a line containing the three decimal color values.

Output

For each test case you should output the Mars RGB value in the following format: first output "#", then followed by a 6-digit number where all the English characters must be upper-cased. If a single color is only 1-digit long, you must print a "0" to the left.

Sample Input
```
15 43 71
```
Sample Output
```
#123456
```

题目大意：给定3个[0,168]范围内的10进制数，将它们转换为13进制数后按顺序输出。
由于题目的数据范围为[0,168]，所以x一定可以表示为x = a*13^1 + b*13^0.
a = x/13, b = x %13
```cpp
#include<cstdio>
#include<cstring>
#include<iostream>
using namespace std;
char radix[13] ={
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C'
};
int main() {
    int r, g, b;
    scanf("%d%d%d", &r, &g, &b);
    printf("#");
    printf("%c%c", radix[r / 13], radix[r % 13]);
    printf("%c%c", radix[g / 13], radix[g % 13]);
    printf("%c%c", radix[b / 13], radix[b % 13]);
    return 0;
}

```