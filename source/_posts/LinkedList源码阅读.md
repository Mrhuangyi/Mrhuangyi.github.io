---
title: LinkedList源码阅读
date: 2019-09-02 13:18:43
tags: Java
---

# LinkedList源码阅读(jdk1.8)

简介：LinkedList继承自AbstractSequentialList，实现了List、Deque、Cloneable、Serializable接口。
底层数据结构为双向链表。
* 实现了List接口，所以可以进行队列操作
* 实现了Deque接口，所以可以进行双端队列操作
* 实现了Cloneable接口，支持克隆
* 实现了Serializable接口，，支持序列化

![alt](https://imgconvert.csdnimg.cn/aHR0cDovL2h1YW5neWlibG9nLmNvbS9MaW5rZWRMaXN0LnBuZw)

### LinkedList和ArrayList区别
* LinkedList基于双向链表实现，ArrayList基于动态数组实现
* LinkedList不支持随机访问，ArrayList支持
* LinkedList插入删除元素效率更高，只需移动指针，平均时间复杂度为O(1)。而ArrayList插入删除元素受元素位置影响，平均时间复杂度为O(n)
* LinkedList与ArrayList都是非同步的，也就是都是非线程安全的
* 内存空间方面：LinkedList在结点结构上由于保存了每个结点的值，前驱和后继指针，所以会有一定的内存占用，ArrayList的内存占用主要体现在扩容后往往不能充分利用已开辟的空间，尾部会有空余。


### 构造函数

```java
     /**
     * 构造一个空的 list.
     */
    public LinkedList() {
    }
     /**
     * 构造一个维护Collection集合元素的 list.
     */
    public LinkedList(Collection<? extends E> c) {
        this();
        addAll(c);
    }
```
# 详细源码

```java
public class LinkedList<E>
    extends AbstractSequentialList<E>
    implements List<E>, Deque<E>, Cloneable, java.io.Serializable
{
    //List中元素的个数
    transient int size = 0;

    /**
     * 指向头结点的指针
     */
    transient Node<E> first;

    /**
     * 指向尾结点的指针
     */
    transient Node<E> last;

    /**
     * 构造一个空的 list.
     */
    public LinkedList() {
    }

    /**
     * 构造一个包含特定集合的List，返回顺序为该集合的迭代器顺序
     */
    public LinkedList(Collection<? extends E> c) {
        this();
        addAll(c);
    }

    /**
     * 将e元素作为第一个结点.
     */
    private void linkFirst(E e) {
        final Node<E> f = first;
        final Node<E> newNode = new Node<>(null, e, f);
        //first指针指向这个新结点
        first = newNode;
        
        if (f == null)
            last = newNode;
        else
            f.prev = newNode;
        size++;
        modCount++;
    }

    /**
     * 将e元素作为最后一个结点
     */
    void linkLast(E e) {
        final Node<E> l = last;
        final Node<E> newNode = new Node<>(l, e, null);
        last = newNode;
        if (l == null)
            first = newNode;
        else
            l.next = newNode;
        size++;
        modCount++;
    }

    /**
     * 在非空结点succ前面插入元素e
     */
    void linkBefore(E e, Node<E> succ) {
        // assert succ != null;
        final Node<E> pred = succ.prev;
        final Node<E> newNode = new Node<>(pred, e, succ);
        succ.prev = newNode;
        if (pred == null)
            first = newNode;
        else
            pred.next = newNode;
        size++;
        modCount++;
    }

    /**
     * 释放首个非空结点f.
     */
    private E unlinkFirst(Node<E> f) {
        // assert f == first && f != null;
        final E element = f.item;
        final Node<E> next = f.next;
        f.item = null;
        f.next = null; // 帮助进行垃圾回收
        first = next;
        if (next == null)
            last = null;
        else
            next.prev = null;
        size--;
        modCount++;
        return element;
    }

    /**
     * 释放最后一个非空结点l
     */
    private E unlinkLast(Node<E> l) {
        // assert l == last && l != null;
        final E element = l.item;
        final Node<E> prev = l.prev;
        l.item = null;
        l.prev = null; // 帮助进行垃圾回收
        last = prev;
        if (prev == null)
            first = null;
        else
            prev.next = null;
        size--;
        modCount++;
        return element;
    }

    /**
     * 释放非空结点x.
     */
    E unlink(Node<E> x) {
        // assert x != null;
        final E element = x.item;
        final Node<E> next = x.next;
        final Node<E> prev = x.prev;

        if (prev == null) {
            first = next;
        } else {
            prev.next = next;
            x.prev = null;
        }

        if (next == null) {
            last = prev;
        } else {
            next.prev = prev;
            x.next = null;
        }

        x.item = null;
        size--;
        modCount++;
        return element;
    }

    /**
     * 返回list里面的第一个元素
     */
    public E getFirst() {
        final Node<E> f = first;
        if (f == null)
            throw new NoSuchElementException();
        return f.item;
    }

    /**
     * 返回list中的最后一个元素
     */
    public E getLast() {
        final Node<E> l = last;
        if (l == null)
            throw new NoSuchElementException();
        return l.item;
    }

    /**
     * 删除list中的第一个元素并返回该元素
     */
    public E removeFirst() {
        final Node<E> f = first;
        if (f == null)
            throw new NoSuchElementException();
        return unlinkFirst(f);
    }

    /**
     * 删除list中的最后一个元素并返回该元素
     */
    public E removeLast() {
        final Node<E> l = last;
        if (l == null)
            throw new NoSuchElementException();
        return unlinkLast(l);
    }

    /**
     * 在list头部插入指定元素e
     */
    public void addFirst(E e) {
        linkFirst(e);
    }

    /**
     * 在list尾部添加指定元素e
     */
    public void addLast(E e) {
        linkLast(e);
    }

    /**
     * 判断list中是否包含指定元素o
     */
    public boolean contains(Object o) {
        return indexOf(o) != -1;
    }

    /**
     * 返回list中的元素个数
     */
    public int size() {
        return size;
    }

    /**
     * 在list尾部添加指定元素e
     */
    public boolean add(E e) {
        linkLast(e);
        return true;
    }

    /**
     * 删除list中第一次出现的某个指定元素e
     * 如果list里面不存在该元素，则无需改变
     */
    public boolean remove(Object o) {
        if (o == null) {
            for (Node<E> x = first; x != null; x = x.next) {
                if (x.item == null) {
                    unlink(x);
                    return true;
                }
            }
        } else {
            for (Node<E> x = first; x != null; x = x.next) {
                if (o.equals(x.item)) {
                    unlink(x);
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 添加指定集合的所有元素到list尾部
     */
    public boolean addAll(Collection<? extends E> c) {
        return addAll(size, c);
    }

    /**
     * 添加指定集合的所有元素到index开始的位置
     */
    public boolean addAll(int index, Collection<? extends E> c) {
        checkPositionIndex(index);

        Object[] a = c.toArray();
        int numNew = a.length;
        if (numNew == 0)
            return false;

        Node<E> pred, succ;
        if (index == size) {
            succ = null;
            pred = last;
        } else {
            succ = node(index);
            pred = succ.prev;
        }

        for (Object o : a) {
            @SuppressWarnings("unchecked") E e = (E) o;
            Node<E> newNode = new Node<>(pred, e, null);
            if (pred == null)
                first = newNode;
            else
                pred.next = newNode;
            pred = newNode;
        }

        if (succ == null) {
            last = pred;
        } else {
            pred.next = succ;
            succ.prev = pred;
        }

        size += numNew;
        modCount++;
        return true;
    }

    /**
     * 删除list中的所有元素
     */
    public void clear() {
        //将结点之间的所有指针都指向null虽不是必须的，但有助于垃圾回收
        for (Node<E> x = first; x != null; ) {
            Node<E> next = x.next;
            x.item = null;
            x.next = null;
            x.prev = null;
            x = next;
        }
        first = last = null;
        size = 0;
        modCount++;
    }


    // Positional Access Operations

    /**
     * 返回list中指定位置的元素
     */
    public E get(int index) {
        checkElementIndex(index);
        return node(index).item;
    }

    /**
     * 替换list中指定位置的元素
     */
    public E set(int index, E element) {
        checkElementIndex(index);
        Node<E> x = node(index);
        E oldVal = x.item;
        x.item = element;
        return oldVal;
    }

    /**
     * 插入指定元素element到list的index位置
     */
    public void add(int index, E element) {
        checkPositionIndex(index);
        //如果index等于list的大小，那么将element添加到list尾部
        if (index == size)
            linkLast(element);
        else
        //否则添加的index位置前面
            linkBefore(element, node(index));
    }

    /**
     * 删除list中指定位置的结点
     */
    public E remove(int index) {
        checkElementIndex(index);
        return unlink(node(index));
    }

    /**
     * 判断给定下标位置是否存在元素
     */
    private boolean isElementIndex(int index) {
        return index >= 0 && index < size;
    }

    /**
     * 判断给定下标是否有效
     */
    private boolean isPositionIndex(int index) {
        return index >= 0 && index <= size;
    }

    /**
     * 构造一个下标越界的返回信息
     */
    private String outOfBoundsMsg(int index) {
        return "Index: "+index+", Size: "+size;
    }

    private void checkElementIndex(int index) {
        if (!isElementIndex(index))
            throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
    }

    private void checkPositionIndex(int index) {
        if (!isPositionIndex(index))
            throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
    }

    /**
     * 返回指定下标的非空结点
     */
    Node<E> node(int index) {
        // assert isElementIndex(index);
        //如果index小于size的一半，那么从前往后遍历
        if (index < (size >> 1)) {
            Node<E> x = first;
            for (int i = 0; i < index; i++)
                x = x.next;
            return x;
        } else {
        //反之，从后往前遍历
            Node<E> x = last;
            for (int i = size - 1; i > index; i--)
                x = x.prev;
            return x;
        }
    }

    // Search Operations

    /**
     * 返回某元素第一次出现的下标位置
     */
    public int indexOf(Object o) {
        int index = 0;
        if (o == null) {
            for (Node<E> x = first; x != null; x = x.next) {
                if (x.item == null)
                    return index;
                index++;
            }
        } else {
            for (Node<E> x = first; x != null; x = x.next) {
                if (o.equals(x.item))
                    return index;
                index++;
            }
        }
        return -1;
    }

    /**
     * 返回某元素最后一次出现的下标位置
     */
    public int lastIndexOf(Object o) {
        int index = size;
        if (o == null) {
            for (Node<E> x = last; x != null; x = x.prev) {
                index--;
                if (x.item == null)
                    return index;
            }
        } else {
            for (Node<E> x = last; x != null; x = x.prev) {
                index--;
                if (o.equals(x.item))
                    return index;
            }
        }
        return -1;
    }

    // 队列操作

    /**
     * 返回list的首个元素
     */
    public E peek() {
        final Node<E> f = first;
        return (f == null) ? null : f.item;
    }

    /**
     * 返回list的首个元素
     */
    public E element() {
        return getFirst();
    }

    /**
     * 删除list的首个元素
     */
    public E poll() {
        final Node<E> f = first;
        return (f == null) ? null : unlinkFirst(f);
    }

    /**
     * 删除list的首个元素
     */
    public E remove() {
        return removeFirst();
    }

    /**
     * 添加指定元素作为list的尾元素
     */
    public boolean offer(E e) {
        return add(e);
    }

    // 出队操作
    /**
     * 在list首部插入元素
     */
    public boolean offerFirst(E e) {
        addFirst(e);
        return true;
    }

    /**
     * 插入指定元素到list尾部
     */
    public boolean offerLast(E e) {
        addLast(e);
        return true;
    }

    /**
     * 返回list的首个元素
     * @since 1.6
     */
    public E peekFirst() {
        final Node<E> f = first;
        return (f == null) ? null : f.item;
     }

    /**
     * 返回list的最后一个元素
     * @since 1.6
     */
    public E peekLast() {
        final Node<E> l = last;
        return (l == null) ? null : l.item;
    }

    /**
     * 删除list的首个元素
     * @since 1.6
     */
    public E pollFirst() {
        final Node<E> f = first;
        return (f == null) ? null : unlinkFirst(f);
    }

    /**
     * 删除list的最后一个元素
     * @since 1.6
     */
    public E pollLast() {
        final Node<E> l = last;
        return (l == null) ? null : unlinkLast(l);
    }

    /**
     * 在list首部添加元素
     * @since 1.6
     */
    public void push(E e) {
        addFirst(e);
    }

    /**
     * 移除list中的首个元素
     * @since 1.6
     */
    public E pop() {
        return removeFirst();
    }

    /**
     * 删除list中第一个出现的指定元素o
     * @since 1.6
     */
    public boolean removeFirstOccurrence(Object o) {
        return remove(o);
    }

    /**
     * 删除list中最后一个出现的指定元素o
     * @since 1.6
     */
    public boolean removeLastOccurrence(Object o) {
        if (o == null) {
            for (Node<E> x = last; x != null; x = x.prev) {
                if (x.item == null) {
                    unlink(x);
                    return true;
                }
            }
        } else {
            for (Node<E> x = last; x != null; x = x.prev) {
                if (o.equals(x.item)) {
                    unlink(x);
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 返回从index开始的list迭代器
     */
    public ListIterator<E> listIterator(int index) {
        checkPositionIndex(index);
        return new ListItr(index);
    }
//List迭代器
    private class ListItr implements ListIterator<E> {
        //上一次返回的结点
        private Node<E> lastReturned;
        //下一个结点
        private Node<E> next;
        //下一个结点对应的索引值
        private int nextIndex;
        //期望改变的索引值，用来实现快速失败机制
        private int expectedModCount = modCount;
        //构造函数,从index开始迭代
        ListItr(int index) {
            // assert isPositionIndex(index);
            next = (index == size) ? null : node(index);
            nextIndex = index;
        }
        //判断是否存在下一个元素
        public boolean hasNext() {
        //根据下一个结点的索引值是否小于size来判断是否到达list末尾
            return nextIndex < size;
        }
        //获取下一个元素
        public E next() {
            checkForComodification();
            if (!hasNext())
                throw new NoSuchElementException();

            lastReturned = next;
            next = next.next;
            nextIndex++;
            return lastReturned.item;
        }
        //是否存在前一个元素
        public boolean hasPrevious() {
            //通过下一个结点的索引是否大于0来判断是否到达首结点
            return nextIndex > 0;
        }
        //获取上一个元素
        public E previous() {
            checkForComodification();
            if (!hasPrevious())
                throw new NoSuchElementException();
            //让next指针指向链表的上一个元素
            lastReturned = next = (next == null) ? last : next.prev;
            nextIndex--;
            return lastReturned.item;
        }
        //获取下一个元素的索引
        public int nextIndex() {
            return nextIndex;
        }
        //获取上一个元素的索引
        public int previousIndex() {
            return nextIndex - 1;
        }
        
        //删除当前元素
        public void remove() {
            checkForComodification();
            if (lastReturned == null)
                throw new IllegalStateException();

            Node<E> lastNext = lastReturned.next;
            unlink(lastReturned);
            if (next == lastReturned)
                next = lastNext;
            else
                nextIndex--;
            lastReturned = null;
            expectedModCount++;
        }
        //设置当前结点为e
        public void set(E e) {
            if (lastReturned == null)
                throw new IllegalStateException();
            checkForComodification();
            lastReturned.item = e;
        }
        //如果next指针为空，将元素e添加到链表的末尾，否则将元素e添加到当前结点的前面
        public void add(E e) {
            checkForComodification();
            lastReturned = null;
            if (next == null)
                linkLast(e);
            else
                linkBefore(e, next);
            nextIndex++;
            expectedModCount++;
        }
        
        public void forEachRemaining(Consumer<? super E> action) {
            Objects.requireNonNull(action);
            while (modCount == expectedModCount && nextIndex < size) {
                action.accept(next.item);
                lastReturned = next;
                next = next.next;
                nextIndex++;
            }
            checkForComodification();
        }
        // 判断modCount和expectedModCount是否相等，依次来实现fail-fast机制
        final void checkForComodification() {
            if (modCount != expectedModCount)
                throw new ConcurrentModificationException();
        }
    }
    //结点的数据结构
    private static class Node<E> {
        //元素值
        E item;
        //后继指针
        Node<E> next;
        //前驱指针
        Node<E> prev;
        //结点的构造函数
        Node(Node<E> prev, E element, Node<E> next) {
            this.item = element;
            this.next = next;
            this.prev = prev;
        }
    }

    /**
     * 反向迭代器
     * @since 1.6
     */
    public Iterator<E> descendingIterator() {
        return new DescendingIterator();
    }

    /**
     * Adapter to provide descending iterators via ListItr.previous
     */
    private class DescendingIterator implements Iterator<E> {
        private final ListItr itr = new ListItr(size());
        public boolean hasNext() {
            return itr.hasPrevious();
        }
        public E next() {
            return itr.previous();
        }
        public void remove() {
            itr.remove();
        }
    }

    @SuppressWarnings("unchecked")
    private LinkedList<E> superClone() {
        try {
            return (LinkedList<E>) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new InternalError(e);
        }
    }

    /**
     * 返回一个list实例的浅拷贝
     */
    public Object clone() {
        LinkedList<E> clone = superClone();

        // Put clone into "virgin" state
        clone.first = clone.last = null;
        clone.size = 0;
        clone.modCount = 0;

        // Initialize clone with our elements
        for (Node<E> x = first; x != null; x = x.next)
            clone.add(x.item);

        return clone;
    }

    /**
     * 按照合适的顺序（从第一个到最后一个）返回一个包含list中所有元素的数组
     */
    public Object[] toArray() {
        Object[] result = new Object[size];
        int i = 0;
        for (Node<E> x = first; x != null; x = x.next)
            result[i++] = x.item;
        return result;
    }

    /**
     * 使用泛型返回LinkedList的模板数组
     */
    @SuppressWarnings("unchecked")
    public <T> T[] toArray(T[] a) {
        if (a.length < size)
            a = (T[])java.lang.reflect.Array.newInstance(
                                a.getClass().getComponentType(), size);
        int i = 0;
        Object[] result = a;
        for (Node<E> x = first; x != null; x = x.next)
            result[i++] = x.item;

        if (a.length > size)
            a[size] = null;

        return a;
    }

    private static final long serialVersionUID = 876323262645176354L;

    /**
     * 序列化的写入函数，将LinkedList的所有元素写入到输出流s中
     */
    private void writeObject(java.io.ObjectOutputStream s)
        throws java.io.IOException {
        // Write out any hidden serialization magic
        s.defaultWriteObject();

        // Write out size
        s.writeInt(size);

        // Write out all elements in the proper order.
        for (Node<E> x = first; x != null; x = x.next)
            s.writeObject(x.item);
    }

    /**
     * 序列化的读取函数
     */
    @SuppressWarnings("unchecked")
    private void readObject(java.io.ObjectInputStream s)
        throws java.io.IOException, ClassNotFoundException {
        // Read in any hidden serialization magic
        s.defaultReadObject();

        // Read in size
        int size = s.readInt();

        // Read in all elements in the proper order.
        for (int i = 0; i < size; i++)
            linkLast((E)s.readObject());
    }

    /**
     * 
     * @since 1.8
     */
    @Override
    public Spliterator<E> spliterator() {
        return new LLSpliterator<E>(this, -1, 0);
    }

    /** A customized variant of Spliterators.IteratorSpliterator */
    static final class LLSpliterator<E> implements Spliterator<E> {
        static final int BATCH_UNIT = 1 << 10;  // batch array size increment
        static final int MAX_BATCH = 1 << 25;  // max batch array size;
        final LinkedList<E> list; // null OK unless traversed
        Node<E> current;      // current node; null until initialized
        int est;              // size estimate; -1 until first needed
        int expectedModCount; // initialized when est set
        int batch;            // batch size for splits

        LLSpliterator(LinkedList<E> list, int est, int expectedModCount) {
            this.list = list;
            this.est = est;
            this.expectedModCount = expectedModCount;
        }

        final int getEst() {
            int s; // force initialization
            final LinkedList<E> lst;
            if ((s = est) < 0) {
                if ((lst = list) == null)
                    s = est = 0;
                else {
                    expectedModCount = lst.modCount;
                    current = lst.first;
                    s = est = lst.size;
                }
            }
            return s;
        }

        public long estimateSize() { return (long) getEst(); }

        public Spliterator<E> trySplit() {
            Node<E> p;
            int s = getEst();
            if (s > 1 && (p = current) != null) {
                int n = batch + BATCH_UNIT;
                if (n > s)
                    n = s;
                if (n > MAX_BATCH)
                    n = MAX_BATCH;
                Object[] a = new Object[n];
                int j = 0;
                do { a[j++] = p.item; } while ((p = p.next) != null && j < n);
                current = p;
                batch = j;
                est = s - j;
                return Spliterators.spliterator(a, 0, j, Spliterator.ORDERED);
            }
            return null;
        }

        public void forEachRemaining(Consumer<? super E> action) {
            Node<E> p; int n;
            if (action == null) throw new NullPointerException();
            if ((n = getEst()) > 0 && (p = current) != null) {
                current = null;
                est = 0;
                do {
                    E e = p.item;
                    p = p.next;
                    action.accept(e);
                } while (p != null && --n > 0);
            }
            if (list.modCount != expectedModCount)
                throw new ConcurrentModificationException();
        }

        public boolean tryAdvance(Consumer<? super E> action) {
            Node<E> p;
            if (action == null) throw new NullPointerException();
            if (getEst() > 0 && (p = current) != null) {
                --est;
                E e = p.item;
                current = p.next;
                action.accept(e);
                if (list.modCount != expectedModCount)
                    throw new ConcurrentModificationException();
                return true;
            }
            return false;
        }

        public int characteristics() {
            return Spliterator.ORDERED | Spliterator.SIZED | Spliterator.SUBSIZED;
        }
    }

}

```