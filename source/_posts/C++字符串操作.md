---
title: C++字符串操作
date: 2018-03-31 16:55:28
tags: C++
categories: 语言
---
# 1）字符串操作 
strcpy(p, p1) 复制字符串 
strncpy(p, p1, n) 复制指定长度字符串 
strcat(p, p1) 附加字符串 
strncat(p, p1, n) 附加指定长度字符串 
strlen(p) 取字符串长度 
strcmp(p, p1) 比较字符串 
strcasecmp忽略大小写比较字符串
strncmp(p, p1, n) 比较指定长度字符串 
strchr(p, c) 在字符串中查找指定字符 
strrchr(p, c) 在字符串中反向查找 
strstr(p, p1) 查找字符串 
strpbrk(p, p1) 以目标字符串的所有字符作为集合，在当前字符串查找该集合的任一元素 
strspn(p, p1) 以目标字符串的所有字符作为集合，在当前字符串查找不属于该集合的任一元素的偏移 
strcspn(p, p1) 以目标字符串的所有字符作为集合，在当前字符串查找属于该集合的任一元素的偏移  
* 具有指定长度的字符串处理函数在已处理的字符串之后填补零结尾符 

# 2）字符串到数值类型的转换 
strtod(p, ppend) 从字符串 p 中转换 double 类型数值，并将后续的字符串指针存储到 ppend 指向的 char* 类型存储。
strtol(p, ppend, base) 从字符串 p 中转换 long 类型整型数值，base 显式设置转换的整型进制，设置为 0 以根据特定格式判断所用进制，0x, 0X 前缀以解释为十六进制格式整型，0    前缀以解释为八进制格式整型
atoi(p) 字符串转换到 int 整型 
atof(p) 字符串转换到 double 符点数 
atol(p) 字符串转换到 long 整型 



```cpp
void *memset(void *dest, int c, size_t count);  
将dest前面count个字符置为字符c.  返回dest的值. 

void *memmove(void *dest, const void *src, size_t count);  
从src复制count字节的字符到dest. 如果src和dest出现重叠, 函数会自动处理.  返回dest的值. 

void *memcpy(void *dest, const void *src, size_t count);  
从src复制count字节的字符到dest. 与memmove功能一样, 只是不能处理src和dest出现重叠.  返回dest的值. 

void *memchr(const void *buf, int c, size_t count);  
在buf前面count字节中查找首次出现字符c的位置. 找到了字符c或者已经搜寻了count个字节, 查找即停止. 操作成功则返回buf中首次出现c的位置指针, 否则返回NULL. 

void *_memccpy(void *dest, const void *src, int c, size_t count);  
从src复制0个或多个字节的字符到dest. 当字符c被复制或者count个字符被复制时, 复制停止. 

如果字符c被复制, 函数返回这个字符后面紧挨一个字符位置的指针. 否则返回NULL. 
```

```cpp
实现strcpy函数,将源串strSrc的内容复制到目标串strDest，返回值为指向目标串的指针
char *strcpy(char *strDest,const char *strSrc)//源字符串+const，表明其为输入参数
{
    assert((strDest!=NULL&&(strSrc!=NULL)));
    //对源地址和目的地址加非0判断
    char *address=strDest;
    while((*strDest++=*strSrc++)!='\0');
    return address;
}
实现strcat函数：将源串添加到str1的末尾，同时覆盖旧串末尾的'\0',在新串末尾+'\0',返回指向str1的指针。
char *strcat(char *str1,char *str2)
{
    char *p=str1;
    assert((str1!=NULL)&&(str2!=NULL));
    while(*str1!='\0')
        str1++;
    while(*str1++=*str2++);
    return p;
}
strcmp函数：比较str1和str2两个字符串的大小，若str1>str2，则返回正数；若str1<str2，则返回负数；若str1==str2，则返回0。
int strcmp(const char *str1,const char *str2)
{
    assert((str1!=NULL)&&(str2!=NULL));
    while(*str1&&*str2&&(*str1==*str2))
    {
        str1++;
        str2++;
    }
    return *str1-*str2;
}
void memset(void *s,int c,size_t n) //将已开辟内存空间s的首n个字节的值设为c
{
    assert(s!=NULL);
    char *tmp=(char *)s;
    while(n--)
    {
        *tmp++=(char)c;
    }
    return s;
}
void memcpy(void *dest,const void *src,size_t n)//从源src所指的内存地址的起始位置开始拷贝n个字节到目标dest所指的内存地址的起始位置中
{
    assert(dest!=NULL&&src!=NULL);
    char *tmpdest=(char *)dest;
    char *tmpsrc=(char *)src;
    while(n-- >0)
        *tmpdest++=*tmpsrc++;
    return dest;
}
```
## 实现C的strstr
功能：从字符串str1中查找是否有字符串str2，
	-如果有，从str1中的str2位置起，返回str1中str2起始位置的指针，如果没有，返回null。
```cpp
char *mystrstr(char *s1 , char *s2)  
{  
    if(*s1==0)  
    {  
        if(*s2)   
            return(char*)NULL;  
        return (char*)s1;  
    }  
    while(*s1)  
    {  
        int i=0;  
        while(1)  
        {  
            if(s2[i]==0)   
                return s1;  
            if(s2[i]!=s1[i])   
                break;  
            i++;  
        }  
        s1++;  
    }  
    return (char*)NULL;  
}  

class Solution {  
public:  
    char *strStr(char *haystack, char *needle) {  
        // Start typing your C/C++ solution below  
        // DO NOT write int main() function  
        int i,j;  
        for (i = j = 0; haystack[i] && needle[j];) {  
            if (haystack[i] == needle[j]) {  
                ++i;  
                ++j;  
            }  
            else {  
                i = i - j + 1;  
                j = 0;  
            }  
        }  
        return needle[j]?0:(haystack + i - j);  
    }  
};  
```
### 用C语言实现函数void *memmove(void *dest, const void *src, size_t n)。
memmove函数的功能死拷贝src所指向内存内容前n个字节到dest所指的地址上。
```cpp
#include <iostream>
#include <cstdio>
#include <cstring>

void * my_memmove( void * const dest, const char * const src, size_t n )
{
   // check parameters
   if( 0 == n )
   {
      return NULL;
   }
   if( NULL == dest || NULL == src )
   {
      return NULL;
   }

   char * psrc = (char *)src;
   char * pdest = (char *)dest;
   if( pdest <= psrc || pdest > psrc + n )
   {
      std::cout << "forward overlapping" << std::endl;
      // copy forward direction
      for( size_t i = 0; i < n; i++ )
      {
         *pdest = *psrc;
         pdest++;
         psrc++;
      }
   }
   else
   {
      std::cout << "backward overlapping" << std::endl;
      // copy backward direction
      pdest = pdest + n;
      psrc = psrc + n;
      for( size_t i = 0; i< n; i++ )
      {
         *pdest = *psrc;
         pdest--;
         psrc--;
      }
   }
   return dest;
}

int main( int argc, char ** argv )
{
   char *src = new char[100];
   sprintf( src, "%s", "hello world!" );
   char * dest = new char[100];
   memset( dest, 0, 100*sizeof(char ) );
   std::cout << src << std::endl;
   char * result = (char*)my_memmove( dest, src, strlen(src) );
   std::cout << result << std::endl;
   delete src;
   delete dest;
   return 0;
}
```
### 设计一个反转字符串的函数 char *reverse_str(char *str),不使用系统函数。
```cpp
// 递归实现字符串反转     
char *reverse(char *str)     
{     
    if( !str )     
    {     
        return NULL;  
    }     
    
    int len = strlen(str);     
    if( len > 1 )     
    {     
        char ctemp =str[0];     
        str[0] = str[len-1];        
        str[len-1] = '/0';// 最后一个字符在下次递归时不再处理     
        reverse(str+1); // 递归调用     
        str[len-1] = ctemp;     
    }     
    
    return str;     
}  
  
// 非递归实现字符串反转  
char *reverse(char *str)     
{     
    if( !str )     
    {     
        return NULL;  
    }     
    
    int len = strlen(str);     
    char temp;     
    for( int i = 0; i < len / 2; i++ )     
    {     
        // 交换前后两个相应位置的字符     
        temp = *(str + i);     
        *(str + i) = *(str + len - 1 - i);     
        *(str + len - 1 - i) = temp;     
    }     
    
    return str;     
}  
  
int _tmain(int argc, _TCHAR* argv[])  
{  
  
    char src[] = {"abcdef"};  
    char *pdest = reverse(src);  
  
    getchar();  
  
    return 0;  
}  
```