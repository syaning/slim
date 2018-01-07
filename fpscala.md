---
layout: page
title:  fp_scala
---
The first exposure I had to Scala was from Martin Odersky's Coursera course entitled,
*"Functional Programming Principles in Scala"*. I really did enjoy this course and found
that the exercises were appropriate for begginers in Scala and functional programming.
To further my learning, I picked up the text by Paul Chiusano and Runar Bjarnason called ["Functional Programming in Scala"](https://www.amazon.ca/Functional-Programming-Scala-Paul-Chiusano/dp/1617290653).
Below is a collection of some of my notes as well as my solutions to the exercises
found in this text.

<ul class="post-list">
	{% for post in site.categories.fpscala %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>
