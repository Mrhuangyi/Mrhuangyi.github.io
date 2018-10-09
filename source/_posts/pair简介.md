---
title: pair简介
date: 2018-04-23 14:51:50
categories: 语言
tags: C++
---
# pair
pair 可以看作一个内部有两个元素的结构体，且这两个元素的类型是可以指定的。
```cpp
struct pair1{
    typename1 first;
    typename2 second;
}
```
### 1. pair定义
需要添加<map>或<utility>头文件
```cpp
pair<typename1,typename2> name;
pair<string,int> p;
pair<string,int> p("haha",5);
//临时构建pair
pair<string,int>("hhha",5);
make_pair("hhha",5);
```
### 2. pair中元素访问
```cpp
#include<iostream>
#include<utility>
#include<string>
using namespace std;
int main()
{
    pair<string,int> p;
    p.first="haha";
    p.second=5;
    cout<<p.first<<" "<<p.second<<endl;
    p=make_pair("xixi",6);
    cout<<p.first<<" "<<p.second<<endl;
    p=pair<string,int>("heihei",555);
    cout<<p.first<<" "<<p.second<<endl;
    return 0;
}

```
### 3. pair常用函数
两个pair类型可直接用==、！=、<、<=、>、>=比较大小，先比较first，若first相等，在比较second
```cpp
#include<iostream>
#include<utility>
#include<string>
using namespace std;
int main()
{
    pair<int,int> p1(5,10);
    pair<int,int> p2(5,15);
    pair<int,int> p3(10,5);
    if(p1<p3) printf("p1<p3\n");
    if(p1<=p3) printf("p1<=p3\n");
    if(p1<p2) printf("p1<p2\n");
    return 0;
}

```
### 4. pair常见用途
* 代替二元结构体及其构造函数，节省编码时间
* 作为map的键值对进行插入
```cpp
#include<iostream>
#include<utility>
#include<string>
#include<map>
using namespace std;
int main()
{
    map<string,int> mp;
    mp.insert(make_pair("heihei",5));
    mp.insert(pair<string,int>("haha",6));
    for(map<string,int>::iterator it=mp.begin();it!=mp.end();it++){
        cout<<it->first<<" "<<it->second<<endl;
    }
    return 0;
}

```
