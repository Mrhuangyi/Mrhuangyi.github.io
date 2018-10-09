---
title: queue简介
date: 2018-04-23 14:06:43
categories: 语言
tags: C++
---
# queue的常见用法
queue 队列，在stl中实现了一个先进先出的容器。
#### 1. queue的定义
```cpp
queue<typename> name;
```
### 2. queue容器内的元素访问
在STL中通过front()访问队首元素，通过back()访问队尾元素
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    queue<int> q;
    for(int i=1;i<=5;i++){
        q.push(i);
    }
    printf("%d %d\n",q.front(),q.back());
    return 0;
}

```
### 3. queue 的常用函数
1. push()
push(x) 将x进行入队
2. front()访问队首元素，back()访问队尾元素。
3. pop() 令队首元素出队
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    queue<int> q;
    for(int i=1;i<=5;i++){
        q.push(i);
    }
    for(int i=1;i<=3;i++){
        q.pop();
    }
    printf("%d",q.front());
    return 0;
}

```
4. empty()
empty()检测queue是否为空，为空，返回true；否则，返回false
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    queue<int> q;
    if(q.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    q.push(1);
    if(q.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    return 0;
}

```
5. size()
size()返回queue内元素的个数
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    queue<int> q;
    for(int i=1;i<=5;i++){
        q.push(i);
    }
    printf("%d\n",q.size());
    return 0;
}

```
# 优先队列 priority_queue的常见用法
优先队列，底层用堆实现。队首元素一定是当前队列中优先级最高的一个。
可以在任何时候往优先队列中加入元素，而优先队列底层的数据结构堆（heap）会随时调整结构，
使每次的队首元素都是优先级最大的。
### 1. priority_queue的定义
```cpp
priority_queue<typename> name;
```
### 2. priority_queue容器内元素访问
通过top()函数来访问队首（堆顶）元素，即优先级最高的元素
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    priority_queue<int> q;
    q.push(3);
    q.push(4);
    q.push(1);
    printf("%d\n",q.top());
    return 0;
}

```
### 3. priority_queue的常用函数
1. push()
push(x) 将元素x入队，时间复杂度O(logn)

2. top()
top() 获得队首元素，时间复杂度O(1)

3. pop()
pop() 令队首元素出队，时间复杂对O(logn)
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    priority_queue<int> q;
    q.push(3);
    q.push(4);
    q.push(1);
    printf("%d\n",q.top());
    q.pop();
    printf("%d\n",q.top());
    return 0;
}

```
4. empty() 
empty()检测优先队列是否为空，为空，返回true，否则返回false，时间复杂度O(1)
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    priority_queue<int> q;
    if(q.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    q.push(1);
    if(q.empty()==true){
        printf("Empty\n");
    }
    else{
        printf("Not Empty\n");
    }
    return 0;
}

```
5. size() 
size() 返回队列内元素个数
```cpp
#include<stdio.h>
#include<queue>
using namespace std;
int main()
{
    priority_queue<int> q;
    for(int i=1;i<=5;i++){
        q.push(i);
    }
    printf("%d\n",q.size());
    return 0;
}
```
### 4. priority_queue内元素优先级位置
* 基本数据类型的优先级位置
一般是数字大的优先级越高
以下两种优先队列定义等价
```cpp
priority_queue<int> q;
priority_queue<int, vector<int>,less<int>> q;
//vector<int> 是指承载底层数据结构堆的容器，less<int>则是对第一个参数的比较类
//less<int>表示数字大的优先级越大，greater<int>表示数字小的优先级越大
```
* 结构体的优先级设置
```cpp
struct fruit{
string name;
int price;
frind bool operator < (const fruit &f1,const fruit &f2){
  return f1.price>f2.price;
}
};
```
