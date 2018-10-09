---
title: set简简介
date: 2018-04-20 20:37:16
categories: 语言
tags: C++
---
# set的常见用法
  set指集合，是一个内部自动有序且不含重复元素的容器。
### 1. set的定义
set<typename> name;
set<int> name;
set<double> name;
set<char> name;
set<node> name;
set数组定义
set<trpename> Arrayname[arraysize];
set<int> a[100];
// a[0]~a[99]中的每一个都是一个set容器
### 2. set容器内元素的访问
set只能通过迭代器访问
```cpp
set<typename>::iterator it;
set<int>::iterator it;
set<char>::iterator ir;
得到迭代器it后，可通过*it访问set内的元素
#include<stdio.h>
#include<set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(3);
    st.insert(4);
    st.insert(5);
    st.insert(3);
    for(set<int>::iterator it = st.begin();it!=st.end();it++){
        printf("%d ",*it);
    }
    return 0;
}

```
### set的常用函数
1. insert()
  insert(x)可将x插入set容器中，并自动排序和去重，时间复杂度为O(logn)
2. find()
  find(x)返回set中对应值x的迭代器，时间复杂度为O(logn)
```cpp
#include<stdio.h>
#include<set>
using namespace std;
int main()
{
    set<int> st;
    for(int i=1;i<=3;i++){
        st.insert(i);
    }
    set<int>::iterator it = st.find(2);///在set里查找2，返回其迭代器
    printf("%d\n",*it);
    return 0;
}

```
3. erase()
两种用法： 删除单个元素
          删除一个区间内的所有元素
* st.erase(it), it为所需要删除元素的迭代器，时间复杂度为O(1)
```cpp
#include<stdio.h>
#include<set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(100);
    st.insert(200);
    st.insert(111);
    st.insert(300);
    st.insert(100);
    st.erase(st.find(100));
    st.erase(st.find(200));
    for(set<int>::iterator it=st.begin();it!=st.end();it++){
        printf("%d ",*it);
    }
    return 0;
}

```
* st.erase(value) value为所要删除元素的值，时间复杂度为O(logn)
```cpp
#include<stdio.h>
#include<set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(100);
    st.insert(200);
    st.insert(111);
    st.insert(300);
    st.insert(100);
    st.erase(111);
    st.erase(200);
    for(set<int>::iterator it=st.begin();it!=st.end();it++){
        printf("%d ",*it);
    }
    return 0;
}

```
* 删除一个区间内的所有元素
st.erase(first,last) 删除[first,last),时间复杂度为O（last-first）
```cpp
#include<stdio.h>
#include<set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(20);
    st.insert(10);
    st.insert(40);
    st.insert(30);
    set<int>::iterator it = st.find(30);
    st.erase(it,st.end());
    for(it = st.begin();it!=st.end();it++){
        printf("%d ",*it);
    }
    return 0;
}

```
4. clear()
  clear()用来清空set中的所有元素，复杂度为O（n）
  ```cpp
  #include<stdio.h>
  #include<set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(20);
    st.insert(10);
    st.insert(40);
    st.insert(30);
    st.clear();
    printf("%d\n",st.size());
    return 0;
}

  ```
  ### set常见用途
  set主要作用 为自动去重并按升序排序
  set中元素具有唯一性，如果要处理不唯一情况，要用multiset
  c++11标准中增加了unordered_set,以散列代替set内部的红黑树（一种自平衡二叉查找树）实现，
  使其可以用来处理只去重但不排序的需求，速度比set快很多
