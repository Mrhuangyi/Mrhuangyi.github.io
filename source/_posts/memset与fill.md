---
title: memset与fill
date: 2018-05-10 12:45:43
categories: 语言
tags: C++
---
# memset

memset是计算机中C/C++语言函数。将s所指向的某一块内存中的后n个 字节的内容全部设置为ch指定的ASCII值，
 
第一个值为指定的内存地址，块的大小由第三个参数指定，这个函数通常为新申请的内存做初始化工作， 其返回值为s。

头文件:memory.h或string.h

函    数：void *memset

原    型 (void *s,int ch,size_t n);

void *memset(void *s, int ch, size_t n);

函数解释：将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s 。

memset：作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法

## 常见错误

第一：memset函数按字节对内存块进行初始化，所以不能用它将int数组初始化为0和-1之外的其他值（除非该值高字节和低字节相同）。

第二：memset(void *s, int ch,size_tn);中key实际范围应该在0~~255，

因为该函数只能取ch的后八位赋值给你所输入的范围的每个字节，

比如int a[5]赋值memset（a,-1,sizeof(int )*5）与memset（a,511,sizeof(int )*5） 所赋值的结果是一样的都为-1；

因为-1的二进制码为（11111111 11111111 11111111 11111111）而511的二进制码为（00000000 00000000 00000001 11111111）后八位都为（11111111)，

所以数组中每个字节，如a[0]含四个字节都被赋值为（11111111），其结果为a[0]（11111111 11111111 11111111 11111111），

及a[0]=-1，因此无论ch多大只有后八位二进制有效，而八位二进制 [2]  的范围（0~255）YKQ改。

而对字符数组操作时则取后八位赋值给字符数组，其八位值作为ASCII [3]  码。


第三： 搞反了 ch 和 n 的位置.

一定要记住如果要把一个char a[20]清零，一定是 memset(a,0,20*sizeof(char));

而不是 memset(a,20*sizeof(char),0);


# fill()函数

用途：

* 按照单元赋值，将一个区间的元素都赋同一个值

* fill(arr, arr + n, 要填入的内容);

头文件：<algorithm>

```cpp
#include <cstdio>
#include <algorithm>
using namespace std;
int main() 
{
    int arr[10];    fill(arr, arr + 10, 2);
    return 0;}
```
## 与memset()函数的区别：

两者都可以用来对数组填充，memset是对按照字节来填充的，所以一般用来填充char型数组，也经常用于填充int型的全0或全-1操作。

```cpp
int arr[10];
memset(arr,0,sizeof(arr));
```
fill是按照单元来填充的，所以可以填充一个区间的任意值。
```cpp
int arr[10];
fill(arr,arr+10,65);
vector<int> arr{0, 1, 2, 3, 4, 5};fill(arr.begin(),arr.end(),65);
```
