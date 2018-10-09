---
title: vector简介
date: 2018-04-20 19:41:59
categories: 语言
tags: C++
---
# vector的常见用法
vector 翻译为向量，也可理解为 变长数组，即长度根据需要而自动改变的数组。
```cpp
1. vector的定义
vector<typename> name;
vector<int> name;
vector<double> name;
vector<char> name;
vector<node> name;
vector<vector<int> > name;
二维：
vector<typename> Arrayname[arraySize];
vector<int> vi[100];
```
### 2. vector容器内元素访问
* 通过下标访问
和访问普通数组一样，对一个定义为vector<typename> vi的vector容器来说，直接访问vi[index]即可。
这里的下标范围为0~vi.size()-1
* 通过迭代器访问
迭代器（iterator）可以理解为类似一种指针的东西，其定义为：
vector<int>::iterator it;
vector<double>::iterator it;
这样即得到迭代器 it 通过*it访问vector里的元素
vector<int> vi;
for(int i=1;i<=5;i++){
  vi.push_back(i);
}
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vector<int>::iterator it = vi.begin();
    for(int i=0;i<5;i++){
        printf("%d ",*(it+i));
    }
    return 0;
}
v[i] 等价于 *(vi.begin()+i)
begin()  用于取vi的首元素地址
而end() 用于取vi尾元素地址的下一个地址，即 左闭右开
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vector<int>::iterator it = vi.begin();
    for(it = vi.begin();it!=vi.end();it++)
    {///vector的迭代器不支持it<vi.end(),所以只能用it!=vi.end();
        printf("%d ",*it);
    }
    return 0;
}
```
### vector常用函数
1. push_back() 在vector后面添加一个元素，时间复杂度为O（1）
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    for(int i=0;i<vi.size();i++){
        printf("%d ",vi[i]);
    }
    return 0;
}

```
2. pop_back() 删除vector的尾元素，时间复杂度为O（）
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vi.pop_back();
    for(int i=0;i<vi.size();i++){
        printf("%d ",vi[i]);
    }
    return 0;
}

```
3. size() 用来获得vector中元素的个数，时间复杂度为O（），size()返回unsigned类型
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    printf("%d",vi.size());

    return 0;
}

```
4. clear() 用来清空vector中所有元素，时间复杂度为o（n）
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vi.clear();
    printf("%d",vi.size());

    return 0;
}

```
5. insert() insert(it,x)用来向vector的任意迭代器it处插入一个元素x，时间复杂度为O（n）
```cpp
#include<stdio.h>
#include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vi.insert(vi.begin()+2,-1);
    for(int i=0;i<vi.size();i++){
        printf("%d ",vi[i]);
    }
    return 0;
}

```
6. erase() 
erase() 有两种用法：删除单个元素；
                   删除一个区间内的所有元素。时间复杂度为O（N）
 
*  删除单个元素
 ```cpp
 #include<stdio.h>
 #include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vi.erase(vi.begin()+3);
    for(int i=0;i<vi.size();i++){
        printf("%d ",vi[i]);
    }
    return 0;
}
 ```
 * 删除一个区间内的所有元素
 erase(first,last) 即删除[first,last)内的所有元素
 ```cpp
 #include<stdio.h>
 #include<vector>
using namespace std;
int main()
{
    vector<int> vi;
    for(int i=1;i<=5;i++){
        vi.push_back(i);
    }
    vi.erase(vi.begin()+1,vi.begin()+4);
    for(int i=0;i<vi.size();i++){
        printf("%d ",vi[i]);
    }
    return 0;
}

 ```
 ### vector常见用途
 1. 存储数据
 
 2. 用邻接表存储图
