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
