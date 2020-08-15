---
title: redis数据结构入门
date: 2019-04-27 20:35:16
tags: Redis
categories: 业务开发
---

<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/redis.jpg" width="660"/> </div><br>

> 参考资料：《redis设计与实现》
# redis介绍
***Redis是一个开源（BSD许可），内存存储的数据结构服务器，可用作数据库，高速缓存和消息队列代理。它支持字符串、哈希表、列表、集合、有序集合，位图，hyperloglogs等数据类型。内置复制、Lua脚本、LRU收回、事务以及不同级别磁盘持久化功能，同时通过Redis Sentinel提供高可用，通过Redis Cluster提供自动分区。***

上面一段话是redis中文网的官方介绍。
有几个关键的点值得注意：
- redis属于内存存储，数据是存在内存里面的
- redis本质是数据结构服务器，官方提供了各种数据结构供你使用，你可以将redis用作数据库或者缓存。
- redis的存储方式为key-value的形式存储，所以redis是非关系型数据库

<!--  more -->
# 为什么我们要用redis
学一门技术之前往往会出现这么一个问题，它好在哪里，为什么值得学？值得用？
官方给出了以下几点优势：
- 性能极高 – Redis能读的速度是110000次/s,写的速度是81000次/s 。
- 丰富的数据类型 – Redis支持二进制案例的 Strings, Lists, Hashes, Sets 及 Ordered Sets 数据类型操作。
- 原子 – Redis的所有操作都是原子性的，同时Redis还支持对几个操作全并后的原子性执行。
- 丰富的特性 – Redis还支持 publish/subscribe, 通知, key 过期等等特性。

我们看到上面第一点就是性能极高！！那么问题来了，redis是怎么做到这么快的读写速度的？这个问题我当时面试的时候也被问到过...说白了就是让你说清楚redis为什么很快？？

# redis为什么很快
关于redis为什么快的问题，有两点我们其实很容易想到：
1. redis是基于内存的，内存的读写速度很快
2. redis是单线程的，在一定程度上减少了竞争锁和频繁的上下文切换

我们知道一般数据库的读写都是需要经过磁盘的，而磁盘的读写速度相对于内存来说绝对是算慢的了，所以我们需要用缓存，我们希望不要每次进行读写都跑去数据库进行操作。mybatis为什么要设置一级缓存，二级缓存？主要还是为了不希望每次读取数据都要到数据库去读取，以提升性能。

但是除了上述两点，还有什么特点是提升了redis的性能的呢？

其实还有一点很重要：redis采用了非阻塞的网络IO多路复用技术来保证多连接的时候系统的高吞吐量。也就是指多个socket网络连接复用同一个线程。

另外还有两点：

4. redis整体的hash数据结构提高了读取速度，以及压缩表和跳跃表等的使用。
5. redis采用了效率较高的事件分离器，内部采用非阻塞执行方式。

# redis的数据类型
Redis支持五种数据类型：string（字符串），hash（哈希），list（列表），set（集合）及zset(sorted set：有序集合)。

| 数据类型 | 可以存储的值 | 操作 |
| :--: | :--: | :--: |
| STRING | 字符串、整数或者浮点数 | 对整个字符串或者字符串的其中一部分执行操作</br> 对整数和浮点数执行自增或者自减操作 |
| LIST | 列表 | 从两端压入或者弹出元素 </br> 对单个或者多个元素</br> 进行修剪，只保留一个范围内的元素 |
| SET | 无序集合 | 添加、获取、移除单个元素</br> 检查一个元素是否存在于集合中</br> 计算交集、并集、差集</br> 从集合里面随机获取元素 |
| HASH | 包含键值对的无序散列表 | 添加、获取、移除单个键值对</br> 获取所有键值对</br> 检查某个键是否存在|
| ZSET | 有序集合 | 添加、获取、删除元素</br> 根据分值范围或者成员来获取元素</br> 计算一个键的排名 |

redis的存储形式为key-value，其中key为字符串，value可以是string、list、hash、set、zset。redis并没有直接使用这些数据结构来构建key-value数据库，而是基于这些数据结构构建了一个对象系统。每个相应的键对象、值对象都有自己的类型、编码、和指向底层数据结构的指针。

## 字符串
string是redis最基本的类型，一个key对应一个value。
string类型是二进制安全的。意思是redis的string可以包含任何数据。比如jpg图片或者序列化的对象 。

实例
```
127.0.0.1:6379> set name "xiaohuang"
OK
127.0.0.1:6379> get name
"xiaohuang"
127.0.0.1:6379> del name
(integer) 1
127.0.0.1:6379> get name
(nil)

```
### SDS(简单动态字符串)
redis自己构建了一种叫做简单动态字符串（SDS）的抽象类型，并将SDS用作redis的默认字符串表示。
每个sdshdr结构表示一个SDS值：
```c
struct sdshdr {
	//记录buf数组中已使用的字节数量
	int len;
	//记录buf数组中未使用的字节数量
	int free;
	//字节数组，用来保存字符串
	char buf[];
}
```
<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/sds.png" width="600"/> </div><br>

- C字符串和SDS的区别

| C字符串 | SDS |
| -- | -- |
| 获取字符串长度的复杂度为O(N) | 获取字符串长度的复杂度为O(1) |
| API不安全，可能会造成缓冲区溢出 | API安全，不会造成缓冲区溢出 |
| 修改字符串长度n次必然要进行N次内存重分配 | 修改字符串N次最多需要N次内存重分配 |
| 只能保存文本数据 | 可以保存文本或二进制 |
| 可以使用所有<string.h>库函数 | 可以使用部分<string.h> 库函数

## 列表
Redis 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素导列表的头部（左边）或者尾部（右边）。

实例：
```
127.0.0.1:6379> lpush list-key redis
(integer) 1
127.0.0.1:6379> lpush list-key mongodb
(integer) 2
127.0.0.1:6379> rpush list-key java
(integer) 3
127.0.0.1:6379> lrange list-key 0 5
1) "mongodb"
2) "redis"
3) "java"

```
### 链表
- redis列表键的底层实现之一为链表

- 每个链表结点listnode的结构表示：
```c
typedef struct listNode {
	//前置节点
	struct listNode *prev;
	//后置节点
	struct listNode *next;
	//结点值
	void *value;
}listNode;
```
- list链表结构
```c
typedef struct list {
	//表头节点
	listNode *head;
	//表尾节点
	listNode *tail;
	//链表节点数量
	unsigned long len;
	//节点值复制函数
	void *(*dup) (void *ptr);
	//节点值释放函数
	void *(*free) (void *ptr);
	//节点值对比函数
	int (*match) (void *ptr, void *key);
}list;
```
<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/list.png" width="600"/> </div><br>

### redis链表特性
- 无环双向链表
- 获取表头指针和表尾指针的复杂度为O(1)
- 获取某个节点的前置节点和后置节点的复杂度为O(1)
- 获取链表中节点数量的复杂度为O(1)
- 链表使用 void*  指针来保存节点值，链表可以保存不同类型的值

## 哈希
Redis hash 是一个键值对集合。

Redis hash是一个string类型的field和value的映射表，hash特别适合用于存储对象。

实例：
```
127.0.0.1:6379> hset hash-key field1 value1
(integer) 1
127.0.0.1:6379> hset hash-key field2 value2
(integer) 1
127.0.0.1:6379> hset hash-key field3 value3
(integer) 1
127.0.0.1:6379> hset hash-key field1 value1
(integer) 0
127.0.0.1:6379> hgetall hash-key
1) "field1"
2) "value1"
3) "field2"
4) "value2"
5) "field3"
6) "value3"
127.0.0.1:6379> hdel hash-key field1
(integer) 1
127.0.0.1:6379> hget hash-key field2
"value2"

```
### hash表结构与哈希表节点结构
```c
typedef struct dictht{
	//哈希表数组
	dictEntry **table;
	//哈希表大小
	unsigned long size;
	//哈希表大小掩码，用于计算索引值，总是等于size-1
	unsigned long sizemask;
	//该哈希表已有节点数量
	unsigned long used;
}dictht;
```
```c
typedef struct dictEntry{
	//键
	void *key;
	//值
	union{
		void *val;
		uint64_t u64;
		int64_t s64;
	}v;
	//指向下个哈希表节点，形成链表
	struct dictEntry *next;
}dictEntry;
```
<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/hash.png" width="600"/> </div><br>


### 字典结构表示
```c
typedef struct dict{
	dictType *type;
	void *privdata;
	dictht ht[2];
	int trehashidx; /* rehashing not in progress if rehashidx == -1 */
}dict;
```

```c
typedef struct dictType {
	//计算哈希值
	unsigned int (*hashFunction) (const void *key);
	//复制键
	void *(*keyDup) (void *privdata, const void *key);
    //复制值
	void *(*valDup) (void *privdata, const void *obj);
	//对比建
	int (*keyCompare) (void *privdata, const void *key1, const void *key2);
	//销毁键
	void (*keyDestructor) (void *privdata, void *key);
	//销毁值
	void (*valDestructor) (void *privdata, void *obj);
}dictType;
```

<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/dict.png" width="600"/> </div><br>

当我们要插入新的键值对到字典里面的时候，首先要根据键值对的键计算得到哈希值，然后根据哈希值得到索引值，最后将相应包含键值对的哈希表节点放到哈希数组的制定索引位置。整个过程你会发现和Java里的HashMap很相似。
**hash = dict->type->hashFunction(key);**
**index = hash & dict->ht[x].sizemask;**

当两个或两个以上的键被分配到哈希表数组的同一个索引出，我们认为此时发生了hash冲突。和HashMap相似，redis的哈希表也是使用链地址法来解决哈希冲突。被分配到同一个索引的多个结点可以利用next指针构成一个单链表，并且为了提升性能，总是将新节点添加到链表的表头位置(复杂度为O(1)),

但是rehash（重新散列）redis和Java并不同，redis采用的是渐进式rehash，而不是一次性完成。因为如果数据量过大，一次性rehash会导致较大的计算延时，可能会导致服务器在一段时间内停止服务。

具体的rehash步骤：
- 为ht[0]分配空间，让字典同时持有ht[0]，ht[1]两个哈希表
- 在字典中维持一个索引计数器变量rehashidx，并将其设为0，表示rehash开始
- 在rehash期间，每次对字典执行添加、查找或更新操作时，程序除了执行指定的操作以外，还会将ht[0]哈希表在rehashidx索引上的所有键值对rehash到ht[1]，当rehash完成后，将rehashidx的值增加1
- 不断执行以上操作，当ht[0]的所有键值对都被rehash到ht[1]，程序将rehashidx的值设为-1，表示rehash完成。

## 集合
集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1)。

实例：
```
127.0.0.1:6379> sadd set-key redis
(integer) 1
127.0.0.1:6379> sadd set-key java
(integer) 1
127.0.0.1:6379> sadd set-key mysql
(integer) 1
127.0.0.1:6379> sadd set-key redis
(integer) 0
127.0.0.1:6379> smembers set-key
1) "java"
2) "redis"
3) "mysql"
127.0.0.1:6379> sismember set-key redis
(integer) 1
127.0.0.1:6379> srem set-key mysql
(integer) 1
127.0.0.1:6379> smembers set-key
1) "java"
2) "redis"

```

### 整数集合(intset)
整数集合是集合键的底层实现之一，当一个集合只包含整数值元素，并且元素数量不多，redis会使用整数集合作为集合键的底层实现。

```c
typedef struct intset{
	//编码方式
	uint32_t encoding;
	//集合包含的元素数量
	uint32_t length;
	//保存元素的数组
	int8_t contents[];
}intset;
```
<div align="center"> <img src="https://xiaohuangyi.oss-cn-hongkong.aliyuncs.com/intset.png" width="600"/> </div><br>

关于整数集合如何升级，可以自行查阅黄建宏的《redis设计与实现》
redis的整数集合底层为有序，无重复的数组，有需要时，程序会改变数组类型。
整数集合只支持升级操作，不支持降级操作

## 有序集合

实例：
```
127.0.0.1:6379> zadd zset-key 11 member1
(integer) 1
127.0.0.1:6379> zadd zset-key 9 member2
(integer) 1
127.0.0.1:6379> zadd zset-key 13 member3
(integer) 1
127.0.0.1:6379> zadd zset-key 13 member3
(integer) 0
127.0.0.1:6379> zrange zset-key 0 -1 withscores
1) "member2"
2) "9"
3) "member1"
4) "11"
5) "member3"
6) "13"
127.0.0.1:6379> zrem zset-key member1
(integer) 1
127.0.0.1:6379> zrange zset-key 0 -1 withscores
1) "member2"
2) "9"
3) "member3"
4) "13"
127.0.0.1:6379>

```

### 跳跃表
跳跃表是一种有序数据结构，属于有序集合键的底层实现之一，它通过在每个节点中维持多个指向其他节点的指针，从而能够快速访问节点。
平均复杂度O(logN)，最坏O(N)复杂度,
如果一个有序集合包含的元素比较多，或者有序集合中元素的成员是比较长的字符串时，redis就会使用跳跃表来作为有序集合键的底层实现。
跳跃表除了在有序集合中用到，在redis的集群节点中也有用作内部数据结构。

跳跃表节点结构
```c
typedef struct zskiplistNode {
	//后退指针
	struct zskiplistNode *backward;
	//分值
	double score;
	//成员对象
	robj *obj;
	//层
	struct zskiplistLevel {
		//前进指针
		struct zskiplistNode *forward;
		//跨度
		unsigned int span;
	}level[];
}zskiplistNode;
```

跳跃表结构

```c
typedef struct zskiplist {
	//表头节点和表尾节点
	structz skiplistNode *header, *tail;
	//表中节点数量
	unsigned long length;
	//表中层数最大的节点的层数
	int level;
}zskiplist;
```

- 每个跳跃表节点的层高都是1到32之间的随机数
- 在同一个跳跃表中，多个节点可以包含相同的分值，但每个节点的成员对象必须唯一
- 跳跃表中的节点按照分值大小进行排序，当分值相同，按照成员对象的大小进行排序

与红黑树等平衡树相比，跳跃表的优势在于：
- 插入速度快，不需要旋转等操作来维持平衡
- 支持无锁操作
- 实现相对简单
