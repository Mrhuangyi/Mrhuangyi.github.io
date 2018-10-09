---
title: 1016 Phone Bills (25)（25 分）
date: 2018-07-23 11:00:41
tags: PAT
categories: 题解集
---

1016 Phone Bills (25)（25 分）
A long-distance telephone company charges its customers by the following rules:

Making a long-distance call costs a certain amount per minute, depending on the time of day when the call is made. When a customer starts connecting a long-distance call, the time will be recorded, and so will be the time when the customer hangs up the phone. Every calendar month, a bill is sent to the customer for each minute called (at a rate determined by the time of day). Your job is to prepare the bills for each month, given a set of phone call records.

Input Specification:

Each input file contains one test case. Each case has two parts: the rate structure, and the phone call records.

The rate structure consists of a line with 24 non-negative integers denoting the toll (cents/minute) from 00:00 - 01:00, the toll from 01:00

02:00, and so on for each hour in the day.
The next line contains a positive number N (<= 1000), followed by N lines of records. Each phone call record consists of the name of the customer (string of up to 20 characters without space), the time and date (mm:dd:hh:mm), and the word "on-line" or "off-line".

For each test case, all dates will be within a single month. Each "on-line" record is paired with the chronologically next record for the same customer provided it is an "off-line" record. Any "on-line" records that are not paired with an "off-line" record are ignored, as are "off-line" records not paired with an "on-line" record. It is guaranteed that at least one call is well paired in the input. You may assume that no two records for the same customer have the same time. Times are recorded using a 24-hour clock.

Output Specification:

For each test case, you must print a phone bill for each customer.

Bills must be printed in alphabetical order of customers' names. For each customer, first print in a line the name of the customer and the month of the bill in the format shown by the sample. Then for each time period of a call, print in one line the beginning and ending time and date (dd:hh:mm), the lasting time (in minute) and the charge of the call. The calls must be listed in chronological order. Finally, print the total charge for the month in the format shown by the sample.

Sample Input:
```
10 10 10 10 10 10 20 20 20 15 15 15 15 15 15 15 20 30 20 15 15 10 10 10
10
CYLL 01:01:06:01 on-line
CYLL 01:28:16:05 off-line
CYJJ 01:01:07:00 off-line
CYLL 01:01:08:03 off-line
CYJJ 01:01:05:59 on-line
aaa 01:01:01:03 on-line
aaa 01:02:00:01 on-line
CYLL 01:28:15:41 on-line
aaa 01:05:02:24 on-line
aaa 01:04:23:59 off-line
```
Sample Output:
```
CYJJ 01
01:05:59 01:07:00 61 $12.10
Total amount: $12.10
CYLL 01
01:06:01 01:08:03 122 $24.40
28:15:41 28:16:05 24 $3.85
Total amount: $28.25
aaa 01
02:00:01 04:23:59 4318 $638.80
Total amount: $638.80
```

题目大意:给出24h中每个小时内的资费，并给出n个通话记录点。要求对每个人的有效通话记录进行资费计算。

第一步：对所有记录进行排序
第二步：对每个用户判断其是否存在有效通话记录
第三步：如果存在有效通话记录，则输出有效通话记录并计费。

```cpp
#include<iostream>
#include<cstdio>
#include<cmath>
#include<algorithm>
#include<cstring>
using namespace std;
const int maxn = 1010;
int toll[25];
struct Record {
    char name[25];
    int month, dd, hh, mm;
    bool statu;
} rec[maxn], temp;
bool cmp(Record a, Record b) {
    int s = strcmp(a.name, b.name);
    if(s != 0) {
        return s < 0;
    } else if(a.month != b.month) {
        return a.month < b.month;
    } else if(a.dd != b.dd) {
        return a.dd < b.dd;
    } else if(a.hh != b.hh) {
        return a.hh < b.hh;
    } else {
        return a.mm < b.mm;
    }
}

void getAns(int on, int off, int& time, int& money) {
    temp = rec[on];
    while(temp.dd < rec[off].dd || temp.hh < rec[off].hh || temp.mm < rec[off].mm) {
        time++;
        money += toll[temp.hh];
        temp.mm++;
        if(temp.mm >= 60) {
            temp.mm = 0;
            temp.hh++;
        }
        if(temp.hh >= 24) {
            temp.hh = 0;
            temp.dd++;
        }
    }
}

int main() {
    for(int i = 0; i < 24; i++) {
        scanf("%d", &toll[i]);
    }
    int n;
    scanf("%d", &n);
    char line[10];
    for(int i = 0; i < n; i++) {
        scanf("%s", rec[i].name);
        scanf("%d:%d:%d:%d", &rec[i].month, &rec[i].dd, &rec[i].hh, &rec[i].mm);
        scanf("%s", line);
        if(strcmp(line, "on-line") == 0) {
            rec[i].statu = true;
        } else {
            rec[i].statu = false;
        }
    }
    sort(rec, rec + n, cmp);
    int on = 0, off, next;
    while(on < n) {
        int needPrint = 0;
        next = on;
        while(next < n && strcmp(rec[next].name, rec[on].name) == 0) {
            if(needPrint == 0 && rec[next].statu) {
                needPrint = 1;
            } else if(needPrint == 1 && rec[next].statu == false) {
                needPrint = 2;
            }
            next++;
        }
        if(needPrint < 2) {
            on = next;
            continue;
        }
        int allMoney = 0;
        printf("%s %02d\n", rec[on].name, rec[on].month);
        while(on < next) {
            while(on < next - 1 && !(rec[on].statu && rec[on + 1].statu == false)) {
                on++;
            }
        off = on + 1;
        if(off == next) {
            on = next;
            break;
        }
        printf("%02d:%02d:%02d ", rec[on].dd, rec[on].hh, rec[on].mm);
        printf("%02d:%02d:%02d ", rec[off].dd, rec[off].hh, rec[off].mm);
        int time = 0, money = 0;
        getAns(on, off, time, money);
        allMoney += money;
        printf("%d $%.2f\n", time, money / 100.0);
        on = off + 1;
    }
    printf("Total amount: $%.2f\n", allMoney / 100.0);
    }
    return 0;
}

```