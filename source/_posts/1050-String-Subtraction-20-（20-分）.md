---
title: 1050 String Subtraction (20)（20 分）
date: 2018-07-27 17:43:16
tags: PAT
categories: 题解集
---

Given two strings S~1~ and S~2~, S = S~1~ - S~2~ is defined to be the remaining string after taking all the characters in S~2~ from S~1~. Your task is simply to calculate S~1~ - S~2~ for any given strings. However, it might not be that simple to do it fast.

Input Specification:

Each input file contains one test case. Each case consists of two lines which gives S~1~ and S~2~, respectively. The string lengths of both strings are no more than 10^4^. It is guaranteed that all the characters are visible ASCII codes and white space, and a new line character signals the end of a string.

Output Specification:

For each test case, print S~1~ - S~2~ in one line.

Sample Input:
```
They are students.
aeiou
```
Sample Output:
```
Thy r stdnts.
```
题目大意：给出两个字符串，在第一个字符串中删去第二个字符串中出现的所有字符并输出。
思路：可以建立一个哈希表来标记第二个字符串中的每个字符，然后遍历第一个字符串，输出符合的字符。

```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<map>
#include<algorithm>
using namespace std;
string a, b;
bool HashTable[128];
int main() {
    getline(cin, a);
    getline(cin, b);
    int lena = a.size();
    int lenb = b.size();
    for(int i = 0; i < lenb; i++) {
        HashTable[b[i]] = true;
    }
    for(int i = 0; i < lena; i++) {
        if(HashTable[a[i]] == false) {
            cout<<a[i];
        }
    }
    return 0;
}

```