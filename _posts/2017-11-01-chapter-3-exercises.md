---
layout: post
title:  "ch3_exercises"
date: 2017-11-01
comments: true
categories: fpscala
---
**<span style="font-size:larger;">Exercise 1.</span>**
What will the result of the following match expression be?
```scala
val x = List(1,2,3,4,5) match {
  case Cons(x, Cons(2, Cons(4, _))) => x
  case Nil => 42
  case Cons(x, Cons(y, Cons(3, Cons(4, _)))) => x+y
  case Cons(h, t) => h + sum(t)
  case _ => 101
}

// Returns
x = 3
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 2.</span>**
Implement the function `tail` for "removing" the first element of `List`
```scala
def tail[A](l: List[A]): List[A] = l  match {
  \\ Using pattern matching
  case Nil => throw new NoSuchElementException("Nil.tail")
  case Cons(_,t) => t
}
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 3.</span>**
Generalize `tail` to the function `drop`, which removes the first `n` elements
from a list.
```scala
def drop[A](l: List[A], n: Int): List[A] = {
  if (n == 0) l // i.e., nothing to drop
  else drop(tail(l), n-1)
}
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 4.</span>**
Implement `dropWhile`, which removes elements from the `List` prefix as long as
they match a predicate.
```scala
def dropWhile[A](l: List[A], f: A => Boolean): List[A] = l match {
  case Cons(h,t) if f(h) => dropWhile(t,f) // pattern matches with predicate f
  case _ => l // any other pattern returns the list l
}
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 5.</span>**
Implement `setHead` for replacing the first element of a `List` with a different
value.
```scala
def setHead[A](l: List[A], h: A): List[A] = l match {
  case Nil => Cons(h, Nil)
  case _ => Cons(h, l)
}
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 6.</span>**
Implement `init`, which returns a `List` containing all but the last element of
a `List`.
```scala
def init[A](l: List[A]): List[A] = l match {
  case Nil => throw new NoSuchElementException("Nil.init")
  case Cons(h, Nil) => Nil
  case Cons(h, t) => Cons(h, init(t))
}

\\ Note this function is not constant time but is instead linear time.
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 9.</span>**
Compute the length of a list using `foldRight`
```scala
def foldRight[A,B](l: list[A], z: B)(f: (A,B) => B): B = l match {
  case Nil => z
  case Cons(x, xs) => f(x, foldRight(xs, z)(f))
}

def length[A](l: list[A]): Int = foldRight(l, 0)((_, b:Int) => 1 + b)
\\ b above represents the length(tail(l)) and is thus an integer
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 10.</span>**
`foldRight` is not tail-recursive. Write another general list-recursion, `foldLeft` that is tail-recursive.
```scala
def foldLeft[A,B](l: List[A], z: B)(f: (B, A) => B): B = {
  @annotation.tailrec
  def go(l: List[A], acc: B): B = l match {
    case Nil => acc
    case Cons(x, xs) => go(xs,f(acc, x))
  }
  go(l, z)
}
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 11.</span>**
Write `sum`, `product`, and a function to compute the length of a list using
`foldLeft`.
```scala
def sumLeft(ns: List[Int]): Int = foldLeft(ns, 0)(_ + _)

def productLeft(ds: List[Double]): Double = foldLeft(ds, 1.0)(_ * _)

def lengthLeft[A](l: List[A]): Int = foldLeft(l,0)((b:Int,_) => 1 + b)

\\ e.g., program trace of go() in sumLeft(List(1,2,3))
go(Cons(1, Cons(2, Cons(3, Nil))), 0)
go(Cons(2, Cons(3, Nil))), 0 + 1)
go(Cons(3, Nil), ((0 + 1) + 2))
go(Nil, ((0 + 1) + 2) + 3))
(((0 + 1) + 2) + 3)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 12.</span>**
Write a function that returns the reverse of a list. See if you can write it
using a fold.
```scala
// Note how the zero-th element is really a Nil, but we can't
// pass in Nil directly or we get a type mismatch at compile time
def reverse[A](l: List[A]): List[A] =
  foldLeft(l, List[A]())((acc, h) => Cons(h, acc))

// THIS DOESN'T WORK
def reverse[A](l: List[A]): List[A] =
  foldLeft(l, Nil)((acc, h) => Cons(h, acc))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 13.</span>**
Write `foldRight` as a function of `foldLeft`.
```scala
// writing foldRight as a function of foldLeft is a common trick to avoiding stack overflows
def foldRightViaFoldLeft[A,B](l: List[A], z: B)(f: (A,B) => B): B =
  foldLeft(reverse(l), z)((b,a) => f(a,b))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 14.</span>**
Implement `append` in terms of either `foldLeft` or `foldRight`
```scala
// when using foldLeft, need to reverse the first list
def appendLeft[A](a1: List[A], a2: List[A]): List[A] =
  foldLeft(reverse(a1), a2)((acc, h) => Cons(h, acc))

def appendRight[A](a1: List[A], a2: List[A]): List[A] =
  foldRight(a1, a2)((h, t) => Cons(h, t))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 15.</span>**
Write a `concat` method that takes a list of lists and concatenates into a single
list. Try to implement this so that it is linear in the total length of all lists.
```scala
// linear time because append is linear in first argument, which
// never grows in the trace of the program
def concat[A](l: List[List[A]]): List[A] = foldRight(l, List[A]())(append)

// e.g.,
val tun: List[List[Int]] = List(List(1,2,3), List(4,5))
concat(tun)
Cons(1,Cons(2,Cons(3,Cons(4,Cons(5,Nil)))))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 16.</span>**
Write a function that transforms a list of integers by adding 1 to each element.
(Reminder: this should be a pure function that returns a new list!)
```scala
def elementIncrement(l: List[Int]): List[Int] =
  foldRight(l, List[Int]())((h, t) => Cons(h + 1, t))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 17.</span>**
Write a function that turns each value in a `List[Double]` into a `String`.
```scala
// with foldRight
def dubToStr(l: List[Double]): List[String] =
  foldRight(l, List[String]())((h,t) => Cons(h.toString(), t))

// using foldLeft
def dubToStr(l: List[Double]): List[String] =
  foldLeft(reverse(l), List[String]())((acc, h) => Cons(h.toString(),acc))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 18.</span>**
Write a function `map`, generalizes modifying each element in a list while
maintaining the structure of the list.
```scala
def map[A,B](l: List[A])(f: A => B): List[B] =
  foldLeft(reverse(l), List[B]())((acc, h) => Cons(f(h),acc))
  // foldRight(l, List[B]())((h,t) => Cons(f(h), t))

// example
val myDubs: List[Double] = List(1.0,2.0,3.0)
map(myDubs)(x => x*2)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 19.</span>**
Write a function `filter` that removes elements from a list unless they satisfy
a given predicate. Use it to remove all odd numbers from a List[Int].
```scala
def filter[A](l: List[A])(f: A => Boolean): List[A] =
  foldRight(l, List[A]()) { (h, t) =>
    if (f(h)) Cons(h, t)
    else t
  }

// removing all odd numbers from list
val y: List[Int] = List(1,2,3,4,5)
filter(y)(x => x % 2 == 0)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 20.</span>**
Write a function `flatMap`, that works like `map` except that the function given
will return a list instead of a single result, and that list should be inserted
into the final resulting list. For instance `flatMap(List(1,2,3))( i => List(i,i))`
should return `List(1,1,2,2,3,3)`.
```scala
def flatMap[A,B](l: List[A])(f: A => List[B]): List[B] = {
  foldRight(l, List[B]())((h,t) => append(f(h),t))
  // foldLeft(reverse(l), List[B]())((acc, h) => append(f(h), acc))
}

// example
flatMap(List(1,2,3))(i => List(i,i))
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 21.</span>**
Can you use `flatMap` to implement `filter`?
```scala
def filter[A](l: List[A])(f: A => Boolean): List[A] =
  flatMap(l)(x => if (f(x)) List(x) else List[A]())

// removing all odd numbers from list
val y: List[Int] = List(1,2,3,4,5)
filter(y)(x => x % 2 == 0)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 21.</span>**
Can you use `flatMap` to implement `filter`?
```scala
def filter[A](l: List[A])(f: A => Boolean): List[A] =
  flatMap(l)(x => if (f(x)) List(x) else List[A]())

// removing all odd numbers from list
val y: List[Int] = List(1,2,3,4,5)
filter(y)(x => x % 2 == 0)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 22.</span>**
Write a function that accepts two lists and constructs a new list by adding
corresponding elements. For example, `List(1,2,3)` and `List(4,5,6)` becomes
`List(5,7,9)`.
```scala
def elementAdd[Int](l1: List[Int], l2: List[Int])(f: (Int,Int) => Int): List[Int] = (l1, l2) match {
  case (Nil, Nil) => Nil
  case (Nil, Cons(y,ys)) => l2
  case (Cons(x,xs), Nil) => l1
  case (Cons(x,xs), Cons(y,ys)) => Cons(f(x,y), elementAdd(xs,ys)(f))
}

// examples
elementAdd(List(1,2,3), List(4,5,6))(_ + _)
elementAdd(List(0,1,2,3), List(4,5,6))(_ + _)
elementAdd(List(1,2,3), List(4,5,6,7))(_ + _)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 23.</span>**
Generalize the function you just wrote so that it's not specific to integers or
addition.
```scala
def elementOperator[A,B](l1: List[A], l2: List[A])(f: (A,A) => B): List[B] = (l1,l2) match {
  case (Nil, Nil) => List[B]()
  case (Nil, Cons(y,ys)) => List[B]()
  case (Cons(x,xs), Nil) => List[B]()
  case (Cons(x,xs), Cons(y,ys)) => Cons(f(x,y), elementOperator(xs,ys)(f))
}

// examples
elementOperator(List(1,2,3), List(4,5,6))(_ + _)
```
\\(\blacksquare\\)

**<span style="font-size:larger;">Exercise 24.</span>**
Implement `hasSubsequence` for checking whether a `List` contains another `List`
as a subsequence.
```scala
def hasSubsequence[A](l: List[A], sub: List[A]): Boolean = {
  def go(l: List[A]): Boolean = l match {
    case Nil => false
    case Cons(x,xs) => {
      val diffs: Int = length(filter(elementOperator(l, sub)((x,y) => x != y))(x=>x))
      if (diffs == 0) true
      else go(tail(l))
    }
  }
  go(l)
}

// examples
hasSubsequence(List(1,2,3,4), List(2,4)) // false
hasSubsequence(List(1,2,3,4), List(2,3)) // true
hasSubsequence(List('a','b','c','d'), List('b','c','d')) // true
```
\\(\blacksquare\\)
