---
title: Vector源码阅读
date: 2019-09-02 13:15:22
tags: Java

---

# Vector源码阅读(基于jdk1.8)

前几天看了ArrayList，今天再来看看Vector，这两个其实大同小异，基本结构都差不多，只是一些细节上有区别：比如线程安全与否，扩容的大小等，Vector的线程安全通过在方法上直接加synchronized实现。扩容默认扩大为原来的2倍。

还是先来看类的定义，搞清类的结构层次：
可以看到Vector继承了AbstractList，实现了List，RandomAccess，Cloneable，Serializable接口。
从上面我们就可以得出Vector是一个矢量队列，支持一些增加、删除、修改、遍历等功能，可以快速随机访问，可以被克隆，支持序列化等
```java
public class Vector<E>
    extends AbstractList<E>
    implements List<E>, RandomAccess, Cloneable, java.io.Serializable
```

接下来看一些变量定义
```java

//底层结构为object数组，和ArrayList一样，不过我们可以注意到访问修饰符有所不同，Vector用protected修饰，而ArrayList用private修饰。我们知道private变量只能被当前类的方法访问，而protected可以被同一包中的所有类和其他包的子类访问
protected Object[] elementData;
//动态数组的实际有效大小
protected int elementCount;
//动态数组的增长系数：若开始没有人为指定，则默认增加一倍的大小
protected int capacityIncrement;
//Vector的序列版本号
private static final long serialVersionUID = -2767605614048989439L;
```

# Vector的四种构造函数


* 默认构造函数
Vector()

* capacity是Vector的默认容量大小。当由于增加数据导致容量增加时，每次容量会增加一倍。
Vector(int capacity)

* capacity是Vector的默认容量大小，capacityIncrement是每次Vector容量增加时的增量值。
Vector(int capacity, int capacityIncrement)

* 创建一个包含collection的Vector
Vector(Collection<? extends E> collection)

```java

    /**
     * 构造一个空的Vector，输入参数为自定义的初始容量和增长系数
     */
    public Vector(int initialCapacity, int capacityIncrement) {
        super();
        //如果初始容量参数<0，抛出异常
        if (initialCapacity < 0)
            throw new IllegalArgumentException("Illegal Capacity: "+
                                               initialCapacity);
        this.elementData = new Object[initialCapacity];
        this.capacityIncrement = capacityIncrement;
    }

    /**
     * 构造一个初始容量为initialCapacity的空的Vector，默认增加一倍大小
     */
    public Vector(int initialCapacity) {
        this(initialCapacity, 0);
    }

    /**
     * 默认构造函数
     */
    public Vector() {
        this(10);
    }

    /**
     * 创建一个包含collection的Vector
     */
    public Vector(Collection<? extends E> c) {
        elementData = c.toArray();
        elementCount = elementData.length;
        // c.toArray might (incorrectly) not return Object[] (see 6260652)
        if (elementData.getClass() != Object[].class)
            elementData = Arrays.copyOf(elementData, elementCount, Object[].class);
    }
```

# Vector扩容

Vector扩容默认扩容为原来的2倍

```java
/**
     * 确定Vector数组当前的容量大小
     */
    public synchronized void ensureCapacity(int minCapacity) {
        if (minCapacity > 0) {
            modCount++;
            ensureCapacityHelper(minCapacity);
        }
    }

    /**
     * 如果当前容量>当前数组长度，那么调用grow(minCapacity)进行扩容，注意这个方法并没有用synchronized修饰，因为他是在ensureCapacity()中被调用的，而ensureCapacity()已经被加锁了
     */
    private void ensureCapacityHelper(int minCapacity) {
        // overflow-conscious code
        if (minCapacity - elementData.length > 0)
            grow(minCapacity);
    }

    /**
     * 设置能够扩展的最大数组大小
     */
    private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;
    //扩容核心函数
    private void grow(int minCapacity) {
        // overflow-conscious code
        //将旧的容量赋值为数组长度
        int oldCapacity = elementData.length;
        //如果容量增量系数>0那么设置新容量为oldCapacity+capacityIncrement，否则为oldCapacity + oldCapacity
        int newCapacity = oldCapacity + ((capacityIncrement > 0) ?
                                         capacityIncrement : oldCapacity);
        //如果新容量<数组实际所需容量，令newCapacity = minCapacity
        if (newCapacity - minCapacity < 0)
            newCapacity = minCapacity;
        //如果新容量大于数组最大扩容大小，如果当前所需容量>MAX_ARRAY_SIZE，那么新容量设为 Integer.MAX_VALUE，否则设为 MAX_ARRAY_SIZE
        if (newCapacity - MAX_ARRAY_SIZE > 0)
            newCapacity = hugeCapacity(minCapacity);
        elementData = Arrays.copyOf(elementData, newCapacity);
    }

    private static int hugeCapacity(int minCapacity) {
        if (minCapacity < 0) // overflow
            throw new OutOfMemoryError();
        return (minCapacity > MAX_ARRAY_SIZE) ?
            Integer.MAX_VALUE :
            MAX_ARRAY_SIZE;
    }

```

# Vector遍历方式
Vector主要支持4中遍历方式

* 通过迭代器遍历元素
* 通过for-each循环遍历
* 利用下标访问随机遍历
* 使用Enumeration遍历

测试代码

```java
package Collection;
import java.util.*;

public class TestVector {
    public static void main(String[] args) {
        Vector v = new Vector();

        v.add(1);
        v.add(2);
        v.add(3);
        v.add(4);
        v.add(5);

        Enumeration enu = v.elements();
        while(enu.hasMoreElements()) {
            System.out.println(enu.nextElement());
        }

        Integer value = null;
        for( Object val : v) {
            System.out.println(val);
        }

        Iterator<Integer> iter = v.iterator();
        while(iter.hasNext()) {
            System.out.println(iter.next());
        }

        for(int i = 0; i < v.size(); i++) {
            System.out.println(v.get(i));
        }
    }
}

```

# 剩余主要方法源码

```java
    /**
     * 将数组Vector中的全部元素都拷贝到数组anArray中去，调用本地方法arraycopy实现
     */
    public synchronized void copyInto(Object[] anArray) {
        System.arraycopy(elementData, 0, anArray, 0, elementCount);
    }

    /**
     * 将当前容量设为实际元素个数
     */
    public synchronized void trimToSize() {
        modCount++;
        int oldCapacity = elementData.length;
        if (elementCount < oldCapacity) {
            elementData = Arrays.copyOf(elementData, elementCount);
        }
    }

    
    /**
     *设置Vector数组的大小
     */
    public synchronized void setSize(int newSize) {
        modCount++;
        // 若 "newSize 大于 Vector容量"，则调整Vector的大小。
        if (newSize > elementCount) {
            ensureCapacityHelper(newSize);
        } else {
         // 若 "newSize 小于/等于 Vector容量"，则将newSize位置开始的元素都设置为null
            for (int i = newSize ; i < elementCount ; i++) {
                elementData[i] = null;
            }
        }
        elementCount = newSize;
    }

    /**
     * 返回Vector的当前容量
     */
    public synchronized int capacity() {
        return elementData.length;
    }

    /**
     * 返回Vector里面的元素个数
     */
    public synchronized int size() {
        return elementCount;
    }

    /**
     * 判断Vector是否为空
     */
    public synchronized boolean isEmpty() {
        return elementCount == 0;
    }

   // 返回“Vector中全部元素对应的Enumeration”    public Enumeration<E> elements() {
        return new Enumeration<E>() {
            int count = 0;
            //判断是否存在下一个元素
            public boolean hasMoreElements() {
                return count < elementCount;
            }
            //获取下一个元素
            public E nextElement() {
                synchronized (Vector.this) {
                    if (count < elementCount) {
                        return elementData(count++);
                    }
                }
                throw new NoSuchElementException("Vector Enumeration");
            }
        };
    }

    /**
     *  返回Vector数组里面是否包含对象o
     */
    public boolean contains(Object o) {
        return indexOf(o, 0) >= 0;
    }

    /**
     * 返回Vector数组中第一次出现对象o的下标，如果不存在，那么返回-1
     */
    public int indexOf(Object o) {
        return indexOf(o, 0);
    }

    /**
     * 返回从index出开始第一次出现对象o的下标，如果不存在，那么返回-1
     */
    public synchronized int indexOf(Object o, int index) {
        if (o == null) {
            for (int i = index ; i < elementCount ; i++)
                if (elementData[i]==null)
                    return i;
        } else {
            for (int i = index ; i < elementCount ; i++)
                if (o.equals(elementData[i]))
                    return i;
        }
        return -1;
    }

    /**
     * 返回对象o在数组中最后一次出现的下标，如果不存在，返回-1
     */
    public synchronized int lastIndexOf(Object o) {
        return lastIndexOf(o, elementCount-1);
    }

    /**
     * 返回从index开始对象o在数组中最后一次出现的下标，如果不存在，返回-1
     */
    public synchronized int lastIndexOf(Object o, int index) {
        if (index >= elementCount)
            throw new IndexOutOfBoundsException(index + " >= "+ elementCount);

        if (o == null) {
            for (int i = index; i >= 0; i--)
                if (elementData[i]==null)
                    return i;
        } else {
            for (int i = index; i >= 0; i--)
                if (o.equals(elementData[i]))
                    return i;
        }
        return -1;
    }

    /**
     * 返回数组指定下标位置的元素，如果index>=elementCount，则抛出数组越界异常
     *         ({@code index < 0 || index >= size()})
     */
    public synchronized E elementAt(int index) {
        if (index >= elementCount) {
            throw new ArrayIndexOutOfBoundsException(index + " >= " + elementCount);
        }

        return elementData(index);
    }

    /**
     * 返回数组的第一个元素
     */
    public synchronized E firstElement() {
        if (elementCount == 0) {
            throw new NoSuchElementException();
        }
        return elementData(0);
    }

    /**
     * 返回数组的最后一个元素
     */
    public synchronized E lastElement() {
        if (elementCount == 0) {
            throw new NoSuchElementException();
        }
        return elementData(elementCount - 1);
    }

    /**
     * 将数组下标为index位置的元素设置为给定obj对象
     */
    public synchronized void setElementAt(E obj, int index) {
        if (index >= elementCount) {
            throw new ArrayIndexOutOfBoundsException(index + " >= " +
                                                     elementCount);
        }
        elementData[index] = obj;
    }

    /**
     * 删除指定下标位置的元素
     */
    public synchronized void removeElementAt(int index) {
        modCount++;
        if (index >= elementCount) {
            throw new ArrayIndexOutOfBoundsException(index + " >= " +
                                                     elementCount);
        }
        else if (index < 0) {
            throw new ArrayIndexOutOfBoundsException(index);
        }
        int j = elementCount - index - 1;
        if (j > 0) {
        //将数组index+1开始往后元素全都往前移一位
            System.arraycopy(elementData, index + 1, elementData, index, j);
        }
        
        elementCount--;
        //让最后一个元素指向null，方便GC工作
        elementData[elementCount] = null; /* to let gc do its work */
    }

    /**
     * 在指定位置插入元素
     */
    public synchronized void insertElementAt(E obj, int index) {
        modCount++;
        if (index > elementCount) {
            throw new ArrayIndexOutOfBoundsException(index
                                                     + " > " + elementCount);
        }
        //增加数组容量
        ensureCapacityHelper(elementCount + 1);
        //从index开始将数组所以元素都往后移一位
        System.arraycopy(elementData, index, elementData, index + 1, elementCount - index);
        //复制新对象
        elementData[index] = obj;
        //元素个数+1
        elementCount++;
    }

    /**
     * 在数组末尾增加一个元素，首先数组的容量增加1
     */
    public synchronized void addElement(E obj) {
        modCount++;
        ensureCapacityHelper(elementCount + 1);
        elementData[elementCount++] = obj;
    }

    /**
     * 删除数组中第一次出现的obj对象
     */
    public synchronized boolean removeElement(Object obj) {
        modCount++;
        int i = indexOf(obj);
        if (i >= 0) {
            removeElementAt(i);
            return true;
        }
        return false;
    }

    /**
     * 删除数组中所有元素，为了便于GC，让每个位置都指向null
     */
    public synchronized void removeAllElements() {
        modCount++;
        // Let gc do its work
        for (int i = 0; i < elementCount; i++)
            elementData[i] = null;

        elementCount = 0;
    }

    /**
     * 返回一个object的克隆
     */
    public synchronized Object clone() {
        try {
            @SuppressWarnings("unchecked")
                Vector<E> v = (Vector<E>) super.clone();
            v.elementData = Arrays.copyOf(elementData, elementCount);
            v.modCount = 0;
            return v;
        } catch (CloneNotSupportedException e) {
            // this shouldn't happen, since we are Cloneable
            throw new InternalError(e);
        }
    }

    /**
     * 返回一个数组包含Vector中的所有元素
     * @since 1.2
     */
    public synchronized Object[] toArray() {
        return Arrays.copyOf(elementData, elementCount);
    }

    /**
     * 返回Vector的模板数组。所谓模板数组，即可以将T设为任意的数据类型
     * @since 1.2
     */
    @SuppressWarnings("unchecked")
    public synchronized <T> T[] toArray(T[] a) {
        if (a.length < elementCount)
            return (T[]) Arrays.copyOf(elementData, elementCount, a.getClass());

        System.arraycopy(elementData, 0, a, 0, elementCount);

        if (a.length > elementCount)
            a[elementCount] = null;

        return a;
    }

    // Positional Access Operations

    @SuppressWarnings("unchecked")
    E elementData(int index) {
        return (E) elementData[index];
    }

    /**
     * 返回指定下标位置的元素
     * @since 1.2
     */
    public synchronized E get(int index) {
        if (index >= elementCount)
            throw new ArrayIndexOutOfBoundsException(index);

        return elementData(index);
    }

    /**
     * 用element替换数组中指定下标位置的元素
     * @since 1.2
     */
    public synchronized E set(int index, E element) {
        if (index >= elementCount)
            throw new ArrayIndexOutOfBoundsException(index);

        E oldValue = elementData(index);
        elementData[index] = element;
        return oldValue;
    }

    /**
     * 在数组末尾添加指定元素
     * @since 1.2
     */
    public synchronized boolean add(E e) {
        modCount++;
        ensureCapacityHelper(elementCount + 1);
        elementData[elementCount++] = e;
        return true;
    }

    /**
     * 删除数组中第一次出现的指定对象
     * @since 1.2
     */
    public boolean remove(Object o) {
        return removeElement(o);
    }

    /**
     * 在数组指定位置插入元素
     * @since 1.2
     */
    public void add(int index, E element) {
        insertElementAt(element, index);
    }

    /**
     * 删除数组指定位置的元素
     * @since 1.2
     */
    public synchronized E remove(int index) {
        modCount++;
        if (index >= elementCount)
            throw new ArrayIndexOutOfBoundsException(index);
        E oldValue = elementData(index);

        int numMoved = elementCount - index - 1;
        if (numMoved > 0)
            System.arraycopy(elementData, index+1, elementData, index,
                             numMoved);
        elementData[--elementCount] = null; // Let gc do its work

        return oldValue;
    }

    /**
     *删除数组所有元素
     * @since 1.2
     */
    public void clear() {
        removeAllElements();
    }

    // Bulk Operations

    /**
     * 返回一个数组是否包含给定集合中的所有元素
     */
    public synchronized boolean containsAll(Collection<?> c) {
        return super.containsAll(c);
    }

    /**
     * 在Vector数组末尾添加特定集合中的所有元素
     * @since 1.2
     */
    public synchronized boolean addAll(Collection<? extends E> c) {
        modCount++;
        Object[] a = c.toArray();
        int numNew = a.length;
        ensureCapacityHelper(elementCount + numNew);
        System.arraycopy(a, 0, elementData, elementCount, numNew);
        elementCount += numNew;
        return numNew != 0;
    }

    /**
     * 删除Vector中在给定集合中存在的所有元素
     * @since 1.2
     */
    public synchronized boolean removeAll(Collection<?> c) {
        return super.removeAll(c);
    }

    /**
     * 删除Vector中在给定集合中不存在的元素
     * @since 1.2
     */
    public synchronized boolean retainAll(Collection<?> c) {
        return super.retainAll(c);
    }

    /**
     * 将给定集合的所有元素插入到Vector的特定位置
     * @since 1.2
     */
    public synchronized boolean addAll(int index, Collection<? extends E> c) {
        modCount++;
        if (index < 0 || index > elementCount)
            throw new ArrayIndexOutOfBoundsException(index);

        Object[] a = c.toArray();
        int numNew = a.length;
        ensureCapacityHelper(elementCount + numNew);

        int numMoved = elementCount - index;
        if (numMoved > 0)
            System.arraycopy(elementData, index, elementData, index + numNew,
                             numMoved);

        System.arraycopy(a, 0, elementData, index, numNew);
        elementCount += numNew;
        return numNew != 0;
    }

    /**
     * 比较两个数组是否相等
     */
    public synchronized boolean equals(Object o) {
        return super.equals(o);
    }

    /**
     * 返回哈希值
     */
    public synchronized int hashCode() {
        return super.hashCode();
    }

    /**
     * 返回数组的字符串表示
     */
    public synchronized String toString() {
        return super.toString();
    }

    /**
     * 获取Vector中fromIndex(包括)到toIndex(不包括)的子集
     */
    public synchronized List<E> subList(int fromIndex, int toIndex) {
        return Collections.synchronizedList(super.subList(fromIndex, toIndex),
                                            this);
    }

    /**
     * 删除Vector中fromIndex到toIndex的元素
     */
    protected synchronized void removeRange(int fromIndex, int toIndex) {
        modCount++;
        int numMoved = elementCount - toIndex;
        System.arraycopy(elementData, toIndex, elementData, fromIndex,
                         numMoved);

        // Let gc do its work
        int newElementCount = elementCount - (toIndex-fromIndex);
        while (elementCount != newElementCount)
            elementData[--elementCount] = null;
    }

    /**
     * 从二进制流中读取对象实例
     */
    private void readObject(ObjectInputStream in)
            throws IOException, ClassNotFoundException {
        ObjectInputStream.GetField gfields = in.readFields();
        int count = gfields.get("elementCount", 0);
        Object[] data = (Object[])gfields.get("elementData", null);
        if (count < 0 || data == null || count > data.length) {
            throw new StreamCorruptedException("Inconsistent vector internals");
        }
        elementCount = count;
        elementData = data.clone();
    }

    /**
     * 序列化保存一个对象的状态
     */
    private void writeObject(java.io.ObjectOutputStream s)
            throws java.io.IOException {
        final java.io.ObjectOutputStream.PutField fields = s.putFields();
        final Object[] data;
        synchronized (this) {
            fields.put("capacityIncrement", capacityIncrement);
            fields.put("elementCount", elementCount);
            data = elementData.clone();
        }
        fields.put("elementData", data);
        s.writeFields();
    }

    /**
     * 返回一个列表迭代器
     * @throws IndexOutOfBoundsException {@inheritDoc}
     */
    public synchronized ListIterator<E> listIterator(int index) {
        if (index < 0 || index > elementCount)
            throw new IndexOutOfBoundsException("Index: "+index);
        return new ListItr(index);
    }

    /**
     * Returns a list iterator over the elements in this list (in proper
     * sequence).
     *
     * <p>The returned list iterator is <a href="#fail-fast"><i>fail-fast</i></a>.
     *
     * @see #listIterator(int)
     */
    public synchronized ListIterator<E> listIterator() {
        return new ListItr(0);
    }

    /**
     * Returns an iterator over the elements in this list in proper sequence.
     *
     * <p>The returned iterator is <a href="#fail-fast"><i>fail-fast</i></a>.
     *
     * @return an iterator over the elements in this list in proper sequence
     */
    public synchronized Iterator<E> iterator() {
        return new Itr();
    }

    /**
     * An optimized version of AbstractList.Itr
     */
    private class Itr implements Iterator<E> {
        int cursor;       // index of next element to return
        int lastRet = -1; // index of last element returned; -1 if no such
        int expectedModCount = modCount;

        public boolean hasNext() {
            // Racy but within spec, since modifications are checked
            // within or after synchronization in next/previous
            return cursor != elementCount;
        }

        public E next() {
            synchronized (Vector.this) {
                checkForComodification();
                int i = cursor;
                if (i >= elementCount)
                    throw new NoSuchElementException();
                cursor = i + 1;
                return elementData(lastRet = i);
            }
        }

        public void remove() {
            if (lastRet == -1)
                throw new IllegalStateException();
            synchronized (Vector.this) {
                checkForComodification();
                Vector.this.remove(lastRet);
                expectedModCount = modCount;
            }
            cursor = lastRet;
            lastRet = -1;
        }

        @Override
        public void forEachRemaining(Consumer<? super E> action) {
            Objects.requireNonNull(action);
            synchronized (Vector.this) {
                final int size = elementCount;
                int i = cursor;
                if (i >= size) {
                    return;
                }
        @SuppressWarnings("unchecked")
                final E[] elementData = (E[]) Vector.this.elementData;
                if (i >= elementData.length) {
                    throw new ConcurrentModificationException();
                }
                while (i != size && modCount == expectedModCount) {
                    action.accept(elementData[i++]);
                }
                // update once at end of iteration to reduce heap write traffic
                cursor = i;
                lastRet = i - 1;
                checkForComodification();
            }
        }

        final void checkForComodification() {
            if (modCount != expectedModCount)
                throw new ConcurrentModificationException();
        }
    }

    /**
     * An optimized version of AbstractList.ListItr
     */
    final class ListItr extends Itr implements ListIterator<E> {
        ListItr(int index) {
            super();
            cursor = index;
        }

        public boolean hasPrevious() {
            return cursor != 0;
        }

        public int nextIndex() {
            return cursor;
        }

        public int previousIndex() {
            return cursor - 1;
        }

        public E previous() {
            synchronized (Vector.this) {
                checkForComodification();
                int i = cursor - 1;
                if (i < 0)
                    throw new NoSuchElementException();
                cursor = i;
                return elementData(lastRet = i);
            }
        }

        public void set(E e) {
            if (lastRet == -1)
                throw new IllegalStateException();
            synchronized (Vector.this) {
                checkForComodification();
                Vector.this.set(lastRet, e);
            }
        }

        public void add(E e) {
            int i = cursor;
            synchronized (Vector.this) {
                checkForComodification();
                Vector.this.add(i, e);
                expectedModCount = modCount;
            }
            cursor = i + 1;
            lastRet = -1;
        }
    }

    @Override
    public synchronized void forEach(Consumer<? super E> action) {
        Objects.requireNonNull(action);
        final int expectedModCount = modCount;
        @SuppressWarnings("unchecked")
        final E[] elementData = (E[]) this.elementData;
        final int elementCount = this.elementCount;
        for (int i=0; modCount == expectedModCount && i < elementCount; i++) {
            action.accept(elementData[i]);
        }
        if (modCount != expectedModCount) {
            throw new ConcurrentModificationException();
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public synchronized boolean removeIf(Predicate<? super E> filter) {
        Objects.requireNonNull(filter);
        // figure out which elements are to be removed
        // any exception thrown from the filter predicate at this stage
        // will leave the collection unmodified
        int removeCount = 0;
        final int size = elementCount;
        final BitSet removeSet = new BitSet(size);
        final int expectedModCount = modCount;
        for (int i=0; modCount == expectedModCount && i < size; i++) {
            @SuppressWarnings("unchecked")
            final E element = (E) elementData[i];
            if (filter.test(element)) {
                removeSet.set(i);
                removeCount++;
            }
        }
        if (modCount != expectedModCount) {
            throw new ConcurrentModificationException();
        }

        // shift surviving elements left over the spaces left by removed elements
        final boolean anyToRemove = removeCount > 0;
        if (anyToRemove) {
            final int newSize = size - removeCount;
            for (int i=0, j=0; (i < size) && (j < newSize); i++, j++) {
                i = removeSet.nextClearBit(i);
                elementData[j] = elementData[i];
            }
            for (int k=newSize; k < size; k++) {
                elementData[k] = null;  // Let gc do its work
            }
            elementCount = newSize;
            if (modCount != expectedModCount) {
                throw new ConcurrentModificationException();
            }
            modCount++;
        }

        return anyToRemove;
    }

    @Override
    @SuppressWarnings("unchecked")
    public synchronized void replaceAll(UnaryOperator<E> operator) {
        Objects.requireNonNull(operator);
        final int expectedModCount = modCount;
        final int size = elementCount;
        for (int i=0; modCount == expectedModCount && i < size; i++) {
            elementData[i] = operator.apply((E) elementData[i]);
        }
        if (modCount != expectedModCount) {
            throw new ConcurrentModificationException();
        }
        modCount++;
    }

    @SuppressWarnings("unchecked")
    @Override
    public synchronized void sort(Comparator<? super E> c) {
        final int expectedModCount = modCount;
        Arrays.sort((E[]) elementData, 0, elementCount, c);
        if (modCount != expectedModCount) {
            throw new ConcurrentModificationException();
        }
        modCount++;
    }

    /**
     * Creates a <em><a href="Spliterator.html#binding">late-binding</a></em>
     * and <em>fail-fast</em> {@link Spliterator} over the elements in this
     * list.
     *
     * <p>The {@code Spliterator} reports {@link Spliterator#SIZED},
     * {@link Spliterator#SUBSIZED}, and {@link Spliterator#ORDERED}.
     * Overriding implementations should document the reporting of additional
     * characteristic values.
     *
     * @return a {@code Spliterator} over the elements in this list
     * @since 1.8
     */
    @Override
    public Spliterator<E> spliterator() {
        return new VectorSpliterator<>(this, null, 0, -1, 0);
    }

    /** Similar to ArrayList Spliterator */
    static final class VectorSpliterator<E> implements Spliterator<E> {
        private final Vector<E> list;
        private Object[] array;
        private int index; // current index, modified on advance/split
        private int fence; // -1 until used; then one past last index
        private int expectedModCount; // initialized when fence set

        /** Create new spliterator covering the given  range */
        VectorSpliterator(Vector<E> list, Object[] array, int origin, int fence,
                          int expectedModCount) {
            this.list = list;
            this.array = array;
            this.index = origin;
            this.fence = fence;
            this.expectedModCount = expectedModCount;
        }

        private int getFence() { // initialize on first use
            int hi;
            if ((hi = fence) < 0) {
                synchronized(list) {
                    array = list.elementData;
                    expectedModCount = list.modCount;
                    hi = fence = list.elementCount;
                }
            }
            return hi;
        }

        public Spliterator<E> trySplit() {
            int hi = getFence(), lo = index, mid = (lo + hi) >>> 1;
            return (lo >= mid) ? null :
                new VectorSpliterator<E>(list, array, lo, index = mid,
                                         expectedModCount);
        }

        @SuppressWarnings("unchecked")
        public boolean tryAdvance(Consumer<? super E> action) {
            int i;
            if (action == null)
                throw new NullPointerException();
            if (getFence() > (i = index)) {
                index = i + 1;
                action.accept((E)array[i]);
                if (list.modCount != expectedModCount)
                    throw new ConcurrentModificationException();
                return true;
            }
            return false;
        }

        @SuppressWarnings("unchecked")
        public void forEachRemaining(Consumer<? super E> action) {
            int i, hi; // hoist accesses and checks from loop
            Vector<E> lst; Object[] a;
            if (action == null)
                throw new NullPointerException();
            if ((lst = list) != null) {
                if ((hi = fence) < 0) {
                    synchronized(lst) {
                        expectedModCount = lst.modCount;
                        a = array = lst.elementData;
                        hi = fence = lst.elementCount;
                    }
                }
                else
                    a = array;
                if (a != null && (i = index) >= 0 && (index = hi) <= a.length) {
                    while (i < hi)
                        action.accept((E) a[i++]);
                    if (lst.modCount == expectedModCount)
                        return;
                }
            }
            throw new ConcurrentModificationException();
        }

        public long estimateSize() {
            return (long) (getFence() - index);
        }

        public int characteristics() {
            return Spliterator.ORDERED | Spliterator.SIZED | Spliterator.SUBSIZED;
        }
    }
}

```
