---
layout: page
title: neural_networks
---
<ul class="post-list">
	{% for post in site.categories.NN %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>
