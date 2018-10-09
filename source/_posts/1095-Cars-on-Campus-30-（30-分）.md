---
title: 1095 Cars on Campus (30)（30 分）
date: 2018-07-27 17:06:37
tags: PAT
categories: 题解集
---

Zhejiang University has 6 campuses and a lot of gates. From each gate we can collect the in/out times and the plate numbers of the cars crossing the gate. Now with all the information available, you are supposed to tell, at any specific time point, the number of cars parking on campus, and at the end of the day find the cars that have parked for the longest time period.

Input Specification:

Each input file contains one test case. Each case starts with two positive integers N (<= 10000), the number of records, and K (<= 80000) the number of queries. Then N lines follow, each gives a record in the format

plate_number hh:mm:ss status

where plate_number is a string of 7 English capital letters or 1-digit numbers; hh:mm:ss represents the time point in a day by hour:minute:second, with the earliest time being 00:00:00 and the latest 23:59:59; and status is either in or out.

Note that all times will be within a single day. Each "in" record is paired with the chronologically next record for the same car provided it is an "out" record. Any "in" records that are not paired with an "out" record are ignored, as are "out" records not paired with an "in" record. It is guaranteed that at least one car is well paired in the input, and no car is both "in" and "out" at the same moment. Times are recorded using a 24-hour clock.

Then K lines of queries follow, each gives a time point in the format hh:mm:ss. Note: the queries are given in ascending order of the times.

Output Specification:

For each query, output in a line the total number of cars parking on campus. The last line of output is supposed to give the plate number of the car that has parked for the longest time period, and the corresponding time length. If such a car is not unique, then output all of their plate numbers in a line in alphabetical order, separated by a space.

Sample Input:
```
16 7
JH007BD 18:00:01 in
ZD00001 11:30:08 out
DB8888A 13:00:00 out
ZA3Q625 23:59:50 out
ZA133CH 10:23:00 in
ZD00001 04:09:59 in
JH007BD 05:09:59 in
ZA3Q625 11:42:01 out
JH007BD 05:10:33 in
ZA3Q625 06:30:50 in
JH007BD 12:23:42 out
ZA3Q625 23:55:00 in
JH007BD 12:24:23 out
ZA133CH 17:11:22 out
JH007BD 18:07:01 out
DB8888A 06:30:50 in
05:10:00
06:30:50
11:00:00
12:23:42
14:00:00
18:00:00
23:59:00
```
Sample Output:
```
1
4
5
2
1
0
1
JH007BD ZD00001 07:20:09
```
题目大意：给出n条记录，每条记录给出一辆车的车牌号，当前时刻，出入校门情况。然后给出k个查询，每个查询给出一个时刻，输出在这个时刻校园内的车辆数。
查询完毕后输出在学校里停留时间最长的车牌号，可以有多个。

思路：
1. 定义车辆结构体，记录单条记录的信息。定义
map< string,int> parkTime ,记录每辆车在校园内停留总时长
2. 将所有记录存放到数组里，并先按车牌号从小到大排序，若车牌号相同，按时间值从小到大排序
3. 遍历所有记录，查找有效值存入valid数组
4. 将valid数组按时间从小到大排序，并进行查询
5. 遍历parkTime，输出停留时间最长的车牌号

```cpp
#include<iostream>
#include<cstdio>
#include<cstring>
#include<map>
#include<algorithm>
using namespace std;
const int maxn = 10010;
struct Car {
    char id[8];
    int time;
    char status[4];
}all[maxn], valid[maxn];
int num = 0;
map<string, int> parkTime;
int timeToint(int hh, int mm, int ss) {
    return hh * 3600 + mm * 60 + ss;
}
bool cmpByIdandTime(Car a, Car b) {
    if(strcmp(a.id, b.id)) {
        return strcmp(a.id, b.id) < 0;
    } else {
        return a.time < b.time;
    }
}
bool cmpByTime(Car a, Car b) {
    return a.time < b.time;
}
int main() {
    int n, k, hh, mm, ss;
    scanf("%d%d", &n, &k);
    for(int i = 0; i < n; i++) {
        scanf("%s %d:%d:%d %s", all[i].id, &hh, &mm, &ss, all[i].status);
        all[i].time = timeToint(hh, mm, ss);
    }
    sort(all, all + n, cmpByIdandTime);
    int maxTime = -1;
    for(int i = 0; i < n - 1; i++) {
        if(!strcmp(all[i].id, all[i+1].id) && !strcmp(all[i].status, "in") && !strcmp(all[i + 1].status, "out")) {
            valid[num++] = all[i];
            valid[num++] = all[i + 1];
            int inTime = all[i + 1].time - all[i].time;
            if(parkTime.count(all[i].id) == 0) {
                parkTime[all[i].id] = 0;
            }
            parkTime[all[i].id] += inTime;
            maxTime = max(maxTime, parkTime[all[i].id]);
        }
    }
    sort(valid, valid + num, cmpByTime);
    int now = 0, numCar = 0;
    for(int i = 0; i < k; i++) {
        scanf("%d:%d:%d", &hh, &mm, &ss);
        int time = timeToint(hh, mm, ss);
        while(now < num && valid[now].time <= time) {
            if(!strcmp(valid[now].status, "in")) {
                numCar++;
            } else {
                numCar--;
            }
            now++;
        }
        printf("%d\n",numCar);
    }
    map<string, int>::iterator it;
    for(it = parkTime.begin(); it != parkTime.end(); it++) {
        if(it->second == maxTime) {
            printf("%s ", it->first.c_str());
        }
    }
    printf("%02d:%02d:%02d\n",maxTime / 3600, maxTime % 3600 / 60, maxTime % 60);
    return 0;
}

```