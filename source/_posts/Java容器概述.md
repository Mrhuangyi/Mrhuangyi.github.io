---
title: Java容器概述
date: 2018-10-22 16:39:48
tags: Java
categories: 语言
---

# Java容器(Container)

## 什么是容器？

容器可以管理对象的生命周期、对象与对象之间的依赖关系。
直白点说容器就是一段Java程序，能够帮助你管理对象间的关系，而不需要你自行编写程序处理。
维基百科定义：
> 在计算机科学中，容器是指实例为其他类的对象的集合的类、数据结构、[1][2]或者抽象数据类型。换言之，它们以一种遵循特定访问规则的系统的方法来存储对象。容器的大小取决于其包含的对象（或元素）的数目。
潜在的不同容器类型的实现可能在空间和时间复杂度上有所差别，这使得在给定应用场景中选择合适的某种实现具有灵活性。

## Java内部的容器类

Java内部的容器类主要分为两类：Collection(集合)与Map(图)

### Collection

![alt](http://pc5wd3ju6.bkt.clouddn.com/java-collections.png)

**Set**

- ***HashSet***
1. 基于哈希表实现，底层使用HashMap来保存所有元素。
2. 不能保证迭代顺序
3. 允许使用null元素

- ***LinkedHashSet***
1. LinkedHashSet底层使用LinkedHashMap来保存所有元素，它继承于HashSet。
2. 内部使用双向链表维护插入顺序。

- ***TreeSet***
1. 基于（TreeMap）红黑树实现
2. TreeSet非同步，线程不安全
3. TreeSet中的元素支持2种排序方式：自然排序 或者 根据创建TreeSet 时提供的 Comparator 进行排序。

**List**

- ***ArrayList***
1. 实现 List 接口、底层使用数组保存所有元素。
2. 相当于动态数组，支持动态扩容。
3. 不同步

- ***vector***
1. Vector 可以实现可增长的对象数组。
2. Vector 实现 List 接口，继承 AbstractList 类，同时还实现RandmoAccess 接口，Cloneable 接口
3. Vector 是线程安全的

- ***LinkedList***
LinkedList 是基于链表实现的（通过名字也能区分开来），
所以它的插入和删除操作比 ArrayList 更加高效。但也是由于其为基于链表的，所以随机访问的效率要比 ArrayList 差。

**Queue**

- ***LinkedList***
可以用于实现双向队列

- ***PriorityQueue***
通过二叉小顶堆实现，可以用一棵完全二叉树表示。
可以用于实现优先队列。优先队列的作用是能保证每次取出的元素都是队列中权值最小的（Java的优先队列每次取最小元素，C++的优先队列每次取最大元素）。
### Map(用于映射（键值对）问题处理)

![alt](http://pc5wd3ju6.bkt.clouddn.com/java-collections1.png)

**HashMap**
1. HashMap根据键的HashCode来实现，访问速度较快，遍历顺序并不确定。
2. HashMap最多只允许一条记录的键为null，允许多条记录的值为null。
3. HashMap线程不安全，也就是说任意时刻可以有多个线程同时写HashMap，所以可能会导致数据的不一致。
4. 如何确保线程安全？可以用 Collections的synchronizedMap方法使HashMap具有线程安全的能力，或者使用ConcurrentHashMap。

**HashTable**
1. HashTable是遗留类，多数功能与HashMap类似，继承自Dictionary类。
2. HashTable是线程安全的。也就是说任意时刻只有一个线程能够写HashTable。
3. HashTable的并发性不如ConcurrentHashMap，因为ConcurrentHashMap引入了分段锁。

**LinkedHashMap**
基于哈希表和链表实现，借助双向链表确保迭代顺序是插入的顺序。

**TreeMap**
1. 基于红黑树实现
2. 默认按照键值得升序进行排序。
3. 在使用TreeMap时，key必须实现Comparable接口或者在构造TreeMap传入自定义的Comparator，
否则会在运行时抛出java.lang.ClassCastException类型的异常。
