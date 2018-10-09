---
title: 1031 Hello World for U (20)（20 分）
date: 2018-07-21 13:05:48
tags: PAT
categories: 题解集
---

1031 Hello World for U (20)（20 分）
Given any string of N (>=5) characters, you are asked to form the characters into the shape of U. For example, "helloworld" can be printed as:
```
h  d
e  l
l  r
lowo
```
That is, the characters must be printed in the original order, starting top-down from the left vertical line with n~1~ characters, then left to right along the bottom line with n~2~ characters, and finally bottom-up along the vertical line with n~3~ characters. And more, we would like U to be as squared as possible -- that is, it must be satisfied that n~1~ = n~3~ = max { k| k <= n~2~ for all 3 <= n~2~ <= N } with n~1~

n~2~ + n~3~ - 2 = N.
Input Specification:

Each input file contains one test case. Each case contains one string with no less than 5 and no more than 80 characters in a line. The string contains no white space.

Output Specification:

For each test case, print the input string in the shape of U as specified in the description.

Sample Input:
```
helloworld!
```
Sample Output:
```
h   !
e   d
l   l
lowor
```
题目大意：题目要求将給定字符串按照“U”字形输出。其中n1为左侧字符数，n2为底部字符数，n3为右侧字符数，且均包含拐角处相交字符，且有如下要求：

- n1 == n3
- n2 >= n1
- n1 尽可能大

***可以找到规律，当两侧的字符数n1,n3总是取(len + 2) / 3时可以满足条件，其中len为字符串长度***

二维数组写法：
```cpp
#include<cstdio>
#include<cstring>
#include<iostream>
using namespace std;
int main() {
    char str[100], ans[40][40];
    scanf("%s", str);
    int len = strlen(str);
    int n1 = (len + 2) / 3, n3 = n1, n2 = len + 2 - n1 - n3;
    for(int i = 1; i <= n1; i++) {
        for(int j = 1; j <= n2; j++) {
            ans[i][j] = ' ';
        }
    }
    int pos = 0;
    for(int i = 1; i <= n1; i++) {
        ans[i][1] = str[pos++];
    }
    for(int j = 2; j <= n2; j++) {
        ans[n1][j] = str[pos++];
    }
    for(int i = n3 - 1; i >= 1; i--) {
        ans[i][n2] = str[pos++];
    }
    for(int i = 1; i <= n1; i++) {
        for(int j = 1; j <= n2; j++) {
            printf("%c", ans[i][j]);
        }
    printf("\n");
    }
    return 0;
}

```

直接输出写法：

```cpp
#include<cstdio>
#include<cstring>
#include<iostream>
using namespace std;
int main() {
    char str[100], ans[40][40];
    scanf("%s", str);
    int len = strlen(str);
    int n1 = (len + 2) / 3, n3 = n1, n2 = len + 2 - n1 - n3;
    for(int i = 0; i < n1 - 1; i++) {
        printf("%c", str[i]);
        for(int j = 0; j < n2 - 2; j++) {
            printf(" ");
        }
        printf("%c\n", str[len - i - 1]);
    }
    for(int i = 0; i < n2; i++) {
        printf("%c", str[n1 + i - 1]);
    }
    return 0;
}

```