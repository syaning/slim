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
