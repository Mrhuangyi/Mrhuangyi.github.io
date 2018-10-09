---
title: algorithm头文件下常用函数
date: 2018-04-23 21:42:07
categories: 语言
tags: C++
---
# algorithm头文件下常用函数
### 1. max(),min(),abs()
max(x,y)和min(x,y)分别返回x和y中的最大值和最小值，且参数必须是两个。
abs(x) 返回x的绝对值。x必须为整数，浮点型的绝对值要用math头文件下的fabs
### 2. swap()
swap(x,y)用来交换x和y的值
### 3. reverse()
reverse(it,it2) 可以将数组指针在[it,it2)之间的元素或容器的迭代器在[it,it2)范围内的元素进行反转。
```cpp
#include<stdio.h>
#include<algorithm>
using namespace std;
int main()
{
    int a[10]={10,11,12,13,14,15};
    reverse(a,a+4);
    for(int i=0;i<6;i++){
        printf("%d ",a[i]);
    }
    return 0;
}

#include<stdio.h>
#include<string>
#include<algorithm>
using namespace std;
int main()
{
    string str="abcdefghi";
    reverse(str.begin()+2,str.begin()+6);
    for(int i=0;i<str.length();i++){
        printf("%c",str[i]);
    }
    return 0;
}

```
### 4. next_permutation()
next_permutation() 给出一个序列在全排列中的下一个序列
```cpp
#include<stdio.h>
#include<string>
#include<algorithm>
using namespace std;
int main()
{
    int a[10]={1,2,3};
    do{
        printf("%d %d %d\n",a[0],a[1],a[2]);
    }while(next_permutation(a,a+3));
    return 0;
}

```
### 5. fill()
fill() 可以把数组或容器中的某一段区间赋为某个相同的值。和memset不同，这里的赋值可以使数组类型对应范围中的任意值。
```cpp
#include<stdio.h>
#include<string>
#include<algorithm>
using namespace std;
int main()
{
    int a[10]={1,2,3,4,5};
    fill(a,a+5,233);
    for(int i=0;i<5;i++){
        printf("%d ",a[i]);
    }
    return 0;
}

```
### 6. sort()
默认为递增排序
* 若要递减排序，需要增加比较函数
```cpp
bool cmp(int a,int b){
  return a>b;
}
sort(a,a+n,cmp);
```
* 结构体数组排序
```cpp
struct node{
  int x,y;
}a[10];
bool cmp(node a,node b){
  return a.x>b.x; 
}
//
bool cmp(int x,int y){
  if(a.x!=b.x) return a.x>b.x;
  else return a.y<b.y;
}
```
* 容器排序，在STL标砖容器中，只有vector/string/deque可以sort
```cpp
#include<stdio.h>
#include<string>
#include<vector>
#include<algorithm>
using namespace std;
bool cmp(int a,int b){
    return a>b;
}
int main()
{
    vector<int> vi;
    vi.push_back(3);
    vi.push_back(1);
    vi.push_back(2);
    sort(vi.begin(),vi.end(),cmp);
    for(int i=0;i<3;i++){
        printf("%d ",vi[i]);
    }
    return 0;
}

```
### 7. lower_bound()和upper_bound()
lower_bound 和 upper_bound()需要用在一个有序数组或容器中。
lower_bound(first,last,val) 用来寻找在数组或容器的[first,last)范围内第一个值大于等于
val元素的位置，如果是数组，返回该位置的指针；若果是容器，返回该位置的迭代器
upper_bound(first,last,val) 用来寻找在数组或容器的[first,last)范围内第一个值大于
val元素的位置，如果是数组，返回该位置的指针；若果是容器，返回该位置的迭代器
```cpp
#include<stdio.h>
#include<string>
#include<vector>
#include<algorithm>
using namespace std;
int main()
{
    int a[10]={1,2,2,3,3,3,5,5,5,5};
    printf("%d,%d\n",lower_bound(a,a+10,3)-a,upper_bound(a,a+10,3)-a);
    return 0;
}

```
