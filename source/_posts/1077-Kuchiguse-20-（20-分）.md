---
title: 1077 Kuchiguse (20)（20 分）
date: 2018-07-22 11:56:48
tags: PAT
categories: 题解集
---

1077 Kuchiguse (20)（20 分）
The Japanese language is notorious for its sentence ending particles. Personal preference of such particles can be considered as a reflection of the speaker's personality. Such a preference is called "Kuchiguse" and is often exaggerated artistically in Anime and Manga. For example, the artificial sentence ending particle "nyan~" is often used as a stereotype for characters with a cat-like personality:

Itai nyan~ (It hurts, nyan~)

Ninjin wa iyada nyan~ (I hate carrots, nyan~)

Now given a few lines spoken by the same character, can you find her Kuchiguse?

Input Specification:

Each input file contains one test case. For each case, the first line is an integer N (2<=N<=100). Following are N file lines of 0~256 (inclusive) characters in length, each representing a character's spoken line. The spoken lines are case sensitive.

Output Specification:

For each test case, print in one line the kuchiguse of the character, i.e., the longest common suffix of all N lines. If there is no such suffix, write "nai".

Sample Input 1:
```
3
Itai nyan~
Ninjin wa iyadanyan~
uhhh nyan~
```
Sample Output 1:
```
nyan~
```
Sample Input 2:
```
3
Itai!
Ninjinnwaiyada T_T
T_T
```
Sample Output 2:
```
nai
```
题目大意：给定n个字符串，求它们的公共后缀，如果不存在公共后缀，那么输出“nai”，可以考虑将每个字符串反转，将问题转换为求最大公共前缀。
```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
int n, minLen = 256, ans = 0;
string s[256];
int main() {
    scanf("%d", &n);
    getchar();
    for(int i = 0; i < n; i++) {
        getline(cin, s[i]);
        int len = s[i].size();
        if(len < minLen) {
            minLen = len;
        }
        reverse(s[i].begin(),s[i].end());
    }
    for(int i = 0; i < minLen; i++) {
        char c = s[0][i];
        bool same = true;
        for(int j = 0; j < n; j++) {
            if(c != s[j][i]) {
                same = false;
                break;
            }
        }
        if(same) {
            ans++;
        } else {
            break;
        }
    }
    if(ans) {
        for(int i = ans - 1; i >= 0; i--) {
            printf("%c", s[0][i]);
        }
    } else {
        printf("nai");
    }
    return 0;
}

```