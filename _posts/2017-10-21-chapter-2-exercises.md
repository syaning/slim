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

\\(\blacksquare\\)
