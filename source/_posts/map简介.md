---
title: map简介
date: 2018-04-22 22:40:38
categories: 语言
tags: C++
---
# map(映射)
  平时定义的数组，其实都是一种映射，但都是将int型映射到其他类型。而map可以将任何基本类型映射到任何基本类型。
  比如建立string型到int型的映射。
### map的定义
```cpp
map<typename1,typename2> mp;
其中 typename1是键的类型，typename2是值的类型
map<string,int> mp;
map<set<int>,string> mp;
```
### map内元素访问
map一般有两种访问方式：通过下标访问或通过迭代器访问。
  1. 通过下标访问
```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['c'] = 20;
    mp['c'] = 30;
    printf("%d\n",mp['c']);
    return 0;
}
```


 2. 通过迭代器访问
 map<typename1,typename2>::iterator it;
 map可以使用it->first来访问键，使用it->second来访问值
```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['m'] =20;
    mp['r'] =30;
    mp['a'] =40;
    for(map<char,int>::iterator it=mp.begin();it!=mp.end();it++){
        printf("%c %d\n",it->first,it->second);
    }
    return 0;
}
//map会以键从小到大的顺序自动排序，这是由于map内部是使用红黑树实现的（set也是），
在建立映射的过程中会自动实现从小到大的排序功能
```
 ### map常用函数实例解析
 1. find()
 find(key)返回键为key的映射的迭代器，时间复杂度为O(logn)
```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    map<char,int>::iterator it = mp.find('b');
    printf("%c %d\n",it->first,it->second);
    return 0;
}
```
 2. erase()
 erase()两种用法：删除单个元素、删除一个区间内所有元素
 * 删除单个元素
 mp.erase(it), 时间复杂度O(1)
 ```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    map<char,int>::iterator it = mp.find('b');
    mp.erase(it);
    for(map<char, int>::iterator it =mp.begin();it!=mp.end();it++){
    printf("%c %d\n",it->first,it->second);
    }
    return 0;
}

 ```
 mp.erase(key) 时间复杂度为O(logn)
 ```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    mp.erase('b');
    for(map<char, int>::iterator it =mp.begin();it!=mp.end();it++){
    printf("%c %d\n",it->first,it->second);
    }
    return 0;
}

 ```
 * 删除一个区间内所有元素
 mp.erase(first,last) first:要删除的区间的其实迭代器
                      last: 要删除的区间的末尾迭代器的下一个地址。
                      时间复杂度：O(last-first)
 ```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    map<char,int>::iterator it = mp.find('b');
    mp.erase(it,mp.end());
    for(map<char, int>::iterator it =mp.begin();it!=mp.end();it++){
    printf("%c %d\n",it->first,it->second);
    }
    return 0;
}

 ```
 3. size()
 size()用来获得map中映射的对数，时间复杂度为O(1)
 ```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    printf("%d\n",mp.size());
    return 0;
}

 ```
 4. clear()
 clear()用来清空map中的所有元素，复杂度为O(n)
 ```cpp
 #include<stdio.h>
 #include<map>
using namespace std;
int main()
{
    map<char,int> mp;
    mp['a'] =1;
    mp['b'] =2;
    mp['c'] =3;
    mp.clear();
    printf("%d\n",mp.size());
    return 0;
}

 ```
 ### map常见用途
 * 需要建立字符（字符串）与整数之间的映射
 * 判断大整数或其他类型数据是否存在的题目，把map当bool数组
 * 字符串和字符串之间的映射
 map的键和值是唯一的，如果一个键要对应多个值，只能用multimap
