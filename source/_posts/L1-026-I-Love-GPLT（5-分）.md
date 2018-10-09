---
title: L1-026 I Love GPLT（5 分）
date: 2018-05-22 17:24:03
tags: PAT
categories: 题解集
---

L1-026 I Love GPLT（5 分）
这道超级简单的题目没有任何输入。

你只需要把这句很重要的话 —— “I Love GPLT”——竖着输出就可以了。

所谓“竖着输出”，是指每个字符占一行（包括空格），即每行只能有1个字符和回车。

```cpp
#include<stdio.h>
#include<string.h>
int main()
{
   int n,i;
   char a[]={"I Love GPLT"};
   n=strlen(a);
   for(i=0;i<n;i++)
   {
       printf("%c\n",a[i]);
   }
   return 0;
}

```