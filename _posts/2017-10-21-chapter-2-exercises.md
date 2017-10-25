---
layout: post
title:  "Chapter 2 Notes & Exercises"
date: 2017-10-21
categories: fpscala
---

#### NOTES

#### EXERCISES

```scala
// Exercise 1: Write a function to compute the nth fibonacci number

def fib(n: Int): Int ={
  def go(m:Int, prev1: Int, prev2: Int): Int =
    // this "loop" increments m by 1 until it hits n
    if (m == n) prev1 + prev2
    else go(m+1, prev2, prev1 + prev2)
  if (n <= 2) n - 1
  else go(1,0,1)
}
```

**Some notes:**
Mathematically, if \\(f(n)\\) represents the \\(n\\)-th Fibonacci number, then we
clearly have that
\\[
\begin{align}
f(n) = f(n-1) + f(n-2).
\end{align}
\\]
While the above formulation is recursive, this didn't really help me all that much
for writing the local tail-recursive function. Instead, I had to think about
a helper function which takes three arguments, namely: an incrementing variable `m` as well as
two other variables that give the previous two numbers of the Fibonacci
sequence.


```scala
// Exercise 2: Implement a polymorphic function to check whether
// an `Array[A]` is sorted
def isSorted[A](as: Array[A], gt: (A,A) => Boolean): Boolean = {
  def go(m: Int): Boolean =
    if (m == as.length) true
    else {
      if (gt(as(m),as(m-1))) go(m+1)
      else false
    }
  go(1)
}

// Examples:
val arr1 = Array(1,2,3)
isSorted(arr1, (x:Int, y:Int) => (x>y))

val arr2 = Array('b','a','c')
isSorted(arr2, (x:Char, y:Char) => (x>y))
```

```scala
// Exercise 3: Implement partial
def partial[A,B,C](a: A, f: (A,B) => C): B => C = {
  b: B => f(a,b)
}

// Examples:
// this returns a function of the form g(b) = 3b
partial(3, (a:Int, b:Int) => a*b )
```
**Some Notes:**
This is the only implementation that compiles; must use an anonymous function.

```scala
// Exercise 4: Implement `curry`.

// Note that `=>` associates to the right, so we could
// write the return type as `A => B => C`
def curry[A,B,C](f: (A, B) => C): A => (B => C) = {
  (a: A) => partial(a, f)
  // OR (a: A) => (b: B) => f(a,b)
}

// Examples:
val multiplier = curry((a:Int, b:Int) => a*b)
multiplier3 = multiplier(3) // this is a function which return 3*b
multiplier3(4)
```
**Some Notes:** *Currying* __converts a function of \\(N\\) arguments into a function
of one argument and returns a function as its result__. I used to think of currying
as a mathematical composition of functions, but I now realize that the two are quite
different. In currying, we are specifying the parameters one at a time, where
each time we specify a parameter, a new function having one less parameter is returned;
this process is continued until we are left with a single one-parameter function.

**Currying**
\\[
f(a,b) = (g(a))(b),
\\]
where \\(g(a)\\) represents some function from `B` to `C`.

**Mathematical Composition**
\\[
f(a) = g(h(a)),
\\]
where \\(g(\cdot)\\) and \\(h(\cdot)\\) are valid mathematical functions.

\\(\blacksquare\\)
