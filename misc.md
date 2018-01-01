---
layout: page
title: misc
---
A collection of brain-dumps on various things...

<ul class="post-list">
	{% for post in site.categories.misc %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>
