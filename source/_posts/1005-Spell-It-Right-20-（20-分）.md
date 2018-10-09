---
title: 1005 Spell It Right (20)（20 分）
date: 2018-07-22 11:12:12
tags: PAT
categories: 题解集
---

1005 Spell It Right (20)（20 分）
Given a non-negative integer N, your task is to compute the sum of all the digits of N, and output every digit of the sum in English.

Input Specification:

Each input file contains one test case. Each case occupies one line which contains an N (<= 10^100^).

Output Specification:

For each test case, output in one line the digits of the sum in English words. There must be one space between two consecutive words, but no extra space at the end of a line.

Sample Input:
```
12345
```
Sample Output:
```
one five
```
题目大意:给定一个非负整数n，求出数位之和，并用英语表示这个总和的每一位。
```cpp
#include<cstdio>
#include<cstring>
char num[10][10]={
     "zero","one","two","three","four","five","six","seven","eight","nine"
};///数字对应单词
char s[111];
int digit[10];
int main()
{
    gets(s);
    int len=strlen(s);
    int sum=0,numLen=0;
    for(int i=0;i<len;i++){
        sum+=(s[i]-'0');
    }
    if(sum==0) {
        printf("%s",num[0]);
    }
    else{
        while(sum!=0){
            digit[numLen++]=sum%10;
            sum/=10;
        }
        for(int i=numLen-1;i>=0;i--){
            printf("%s",num[digit[i]]);
            if(i!=0) printf(" ");
        }
    }
    return 0;
}

```