---
layout: post
title:  "ch4_exercises"
date: 2018-02-04
comments: true
categories: fpscala
---
**<span style="font-size:larger;">Exercise 1.</span>**
Implement `map`, `getOrElse`, `flatMap`, `orElse`, and `filter` on `Option`.
```scala
sealed trait Option[+A] {
  def map[B](f: A => B): Option[B] = this match {
    case None => None
    case Some(a) => Some(f(a))
  }

  def getOrElse[B >: A](default: => B): B = this match {
    case None => default
    case Some(a) => a
  }
  def flatMap[B](f: A => Option[B]): Option[B] = map(f) getOrElse None

  def orElse[B >: A](ob: => Option[B]): Option[B] = this map (Some(_)) getOrElse ob

  def filter(f: A => Boolean): Option[A] = this match {
    case Some(a) if (f(a)) => this
    case _ => None
  }
}
```
\\(\blacksquare\\)
