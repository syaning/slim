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
