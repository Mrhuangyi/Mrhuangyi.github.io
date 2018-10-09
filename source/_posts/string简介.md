---
title: string简介
date: 2018-04-20 23:08:57
categories: 语言
tags: C++
---
# string 的常见用法
### 1. string的定义
string str;
string str= "abcd";
### 2. string 内容访问
* 通过下标访问
```cpp
#include<stdio.h>
#include<string>
using namespace std;
int main(){
    string str="abcd";
    for(int i=0;i<str.length();i++){
        printf("%c",str[i]);
    }
    return 0;
}
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str;
    cin>>str;
    cout<<str;
    return 0;
}
#include<stdio.h>
#include<string>
using namespace std;
int main()
{
    string str="abcd";
    printf("%s\n",str.c_str());///用C_str()将string类型转换为字符数组
    return 0;
}
```
* 通过迭代器访问
```cpp
#include<stdio.h>
#include<string>
using namespace std;
int main()
{
    string str="abcd";
    for(string::iterator it=str.begin();it!=str.end();it++){
        printf("%c",*it);
    }
    return 0;
}
```
### 3.string 常用函数
* operator +=
string加法
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str1="abcd",str2="xya",str3;
    str3=str1+str2;
    str1+=str2;
    cout<<str1<<endl;
    cout<<str2<<endl;
    return 0;
}

```
* compare operator
两个string类型可直接使用==、！=、<、<=、>、>=比较大小，比较规则为字典序
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str1="aaa",str2="bbb",str3="ccc",str4="qqq";
    if(str1<str2) printf("ok\n");
    return 0;
}

```
* length()/size()
  返回string的长度，两者用法基本相同
* insert()
insert(pos,string),在pos号位置插入字符串string
insert(it,it2,it3) it为原字符串的欲插入位置，it2，it3为待插字符串的首尾迭代器
表示串[it2,it3)将被插在it位置
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "abcxyz",str2="opq";
    str.insert(str.begin()+3,str2.begin(),str2.end());
    cout<<str<<endl;
    return 0;
}

```
* erase()
1. 删除单个元素
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "abcxyzefs";
    str.erase(str.begin()+4);
    cout<<str<<endl;
    return 0;
}
```
2. 删除一个区间内所有元素
* str.erase(first,last) 删除[first,last)
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "abcxyzefs";
    str.erase(str.begin()+2,str.end()-1);
    cout<<str<<endl;
    return 0;
}
```
* str.erase(pos,length) pos 为要删除的起始位置，length为删除的字符个数
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "abcxyzefs";
    str.erase(3,2);
    cout<<str<<endl;
    return 0;
}

```
* clear() 清空string中的数据
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "abcxyzefs";
    str.clear();
    printf("%d\n",str.length());
    return 0;
}

```
* substr()
substr(pos,len) 返回从pos号位开始，长度为len的子串，时间复杂度为O(len)
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str = "Thank you for your smile!";
    cout<<str.substr(0,5)<<endl;
       return 0;
}

```
* string::npos
string::npos 是一个常数，其本身值为-1，由于属于unsigned_int 类型，可认作unsigned_int类型的最大值
string::npos用以作为find函数失败时的的返回值
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    if(string::npos==-1){
        cout<<"-1 is true."<<endl;
    }
    if(string::npos==4294967295){
        cout<<"4294967295 is alse true"<<endl;
    }
       return 0;
}

```
* find()
str.find(str2),当str2是str的子串，返回其在str中第一次出现的位置；如果不是，那么返回string::npos
str.find(str2,pos) 从str的pos号位开始匹配str2
复杂度为O(mn)
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str= "Thank you for your smile";
    string str2="you";
    string str3="me";
    if(str.find(str2)!=string::npos){
        cout<<str.find(str2)<<endl;
    }
    if(str.find(str2,7)!=string::npos){
        cout<<str.find(str2,7)<<endl;
    }
    if(str.find(str3)!=string::npos){
        cout<<str.find(str3)<<endl;
    }
    else{
        cout<<"no position for me"<<endl;
    }
       return 0;
}

```
* replace()
str.replace(pos,len,str2) 把str从pos号位开始，长度为len的子串替换为str2
str.replace(it1,it2,str2) 把str的迭代器[it1,it2)范围的子串替换为str2
```cpp
#include<iostream>
#include<string>
using namespace std;
int main()
{
    string str= "Thank you for your smile";
    string str2="you";
    string str3="me";
    cout<<str.replace(10,4,str2)<<endl;
    cout<<str.replace(str.begin(),str.begin()+5,str3)<<endl;
       return 0;
}

```
