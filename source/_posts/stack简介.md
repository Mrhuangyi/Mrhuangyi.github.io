---
title: stack简介
date: 2018-04-23 14:27:05
categories: 语言
tags: C++
---
# stack常见用法
stack 指栈，是STL中实现的一个后进先出的容器
### 1. stack定义
```cpp
stack<int> name;
```
### 2. stack内容器元素访问
只能通过top()来访问栈顶元素
```cpp
#include<stdio.h>
#include<stack>
using namespace std;
int main()
{
    stack<int> st;
    for(int i=1;i<=5;i++){
        st.push(i);
    }
    printf("%d\n",st.top());
    return 0;
}

```
### 3. stack常用函数
1. push()
push(x) 将元素x压栈，时间复杂度 O(1)

2. top()
top() 获得栈顶元素，时间复杂度 O(1)

3. pop()
pop() 用来弹出栈顶元素，时间复杂度 O(1)
```cpp
#include<stdio.h>
#include<stack>
using namespace std;
int main()
{
    stack<int> st;
    for(int i=1;i<=5;i++){
        st.push(i);
    }
    for(int i=1;i<=3;i++){
        st.pop();
    }
    printf("%d\n",st.top());
    return 0;
}

```
4. empty()
empty() 判断stack是否为空，为空返回true，否则返回false。
```cpp
#include<stdio.h>
#include<stack>
using namespace std;
int main()
{
    stack<int> st;
    if(st.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    st.push(1);
    if(st.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    return 0;
}

```
5. size()
返回stack内元素个数
```cpp
#include<stdio.h>
#include<stack>
using namespace std;
int main()
{
    stack<int> st;
    for(int i=1;i<=5;i++){
        st.push(i);
    }
    printf("%d\n",st.size());
    return 0;
}

```
### stack常见用途
stack 常被用于模拟实现一些递归，防止程序对栈内存的限制而导致程序运行出错

