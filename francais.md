---
layout: page
title: français
---
 Mon blog français où je raconte tout ce que je veux.

 <ul class="post-list">
 	{% for post in site.categories.french %}
 	<li>
 		<span>{{ post.date | date: "%b %d, %Y" }}</span>
 		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
 	</li>
 	{% endfor %}
 </ul>
