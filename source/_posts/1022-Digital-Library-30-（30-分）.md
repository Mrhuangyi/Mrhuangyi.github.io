---
title: 1022 Digital Library (30)（30 分）
date: 2018-08-10 15:06:17
tags: PAT
categories: 题解集
---

1022 Digital Library (30)（30 分）
A Digital Library contains millions of books, stored according to their titles, authors, key words of their abstracts, publishers, and published years. Each book is assigned an unique 7-digit number as its ID. Given any query from a reader, you are supposed to output the resulting books, sorted in increasing order of their ID's.

Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer N (<=10000) which is the total number of books. Then N blocks follow, each contains the information of a book in 6 lines:

Line #1: the 7-digit ID number;
Line #2: the book title -- a string of no more than 80 characters;
Line #3: the author -- a string of no more than 80 characters;
Line #4: the key words -- each word is a string of no more than 10 characters without any white space, and the keywords are separated by exactly one space;
Line #5: the publisher -- a string of no more than 80 characters;
Line #6: the published year -- a 4-digit number which is in the range [1000, 3000].
It is assumed that each book belongs to one author only, and contains no more than 5 key words; there are no more than 1000 distinct key words in total; and there are no more than 1000 distinct publishers.

After the book information, there is a line containing a positive integer M (<=1000) which is the number of user's search queries. Then M lines follow, each in one of the formats shown below:

1: a book title
2: name of an author
3: a key word
4: name of a publisher
5: a 4-digit number representing the year
Output Specification:

For each query, first print the original query in a line, then output the resulting book ID's in increasing order, each occupying a line. If no book is found, print "Not Found" instead.

Sample Input:
```
3
1111111
The Testing Book
Yue Chen
test code debug sort keywords
ZUCS Print
2011
3333333
Another Testing Book
Yue Chen
test code sort keywords
ZUCS Print2
2012
2222222
The Testing Book
CYLL
keywords debug book
ZUCS Print2
2011
6
1: The Testing Book
2: Yue Chen
3: keywords
4: ZUCS Print
5: 2011
3: blablabla
```
Sample Output:
```
1: The Testing Book
1111111
2222222
2: Yue Chen
1111111
3333333
3: keywords
1111111
2222222
3333333
4: ZUCS Print
1111111
5: 2011
1111111
2222222
3: blablabla
Not Found
```
题目大意:给出n本书的编号、书名、作者、关键词、出版社、出版年份，然后根据某个除编号外的信息来查询该信息的书的编号，并按要求按编号从小到大顺序输出。

可以用map< string, set < int >> 分别建立书名、作者、关键词、出版社、出版年份与编号的映射

```cpp
#include<iostream>
#include<string>
#include<map>
#include<set>
#include<cstdio>
using namespace std;
map<string, set<int>> mpTitle, mpAuthor, mpKey, mpPub,mpYear;
void query(map<string, set<int>>& mp, string& str) {
    if(mp.find(str) == mp.end()) {
        printf("Not Found\n");
    } else {
        for(set<int>::iterator it = mp[str].begin(); it != mp[str].end(); it++) {
            printf("%07d\n", *it);
        }
    }
}
int main() {
    int n, m, id, type;
    string title, author, key, pub, year;
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {
        scanf("%d", &id);
        char c = getchar();
        getline(cin, title);
        mpTitle[title].insert(id);
        getline(cin, author);
        mpAuthor[author].insert(id);
        while(cin >> key) {
            mpKey[key].insert(id);
            c = getchar();
            if(c == '\n') {
                break;
            }
        }
            getline(cin, pub);
            mpPub[pub].insert(id);
            getline(cin, year);
            mpYear[year].insert(id);
        }
        string temp;
        scanf("%d", &m);
        for(int i = 0; i < m; i++) {
            scanf("%d: ", &type);
            getline(cin, temp);
            cout<<type<<": "<<temp<<endl;
            if(type == 1) {
                query(mpTitle, temp);
            } else if(type == 2) {
                query(mpAuthor, temp);
            } else if(type == 3) {
                query(mpKey, temp);
            } else if(type == 4) {
                query(mpPub, temp);
            } else {
                query(mpYear, temp);
            }
        }
    return 0;
}

```