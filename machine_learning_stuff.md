---
layout: page
title: machine_learning
---
Posts about my experiences with machine learning!

<ul class="post-list">
	{% for post in site.categories.NN %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>
