---
layout: page
title: paper_summaries
---
It's easy for me to forget the contents of a paper after I've read it. And so, I've
decided to summarize the *"Why?"*, *"How?"*, and *"What?"* of some the ones that
I've read.

#### stats
<ul class="post-list">
	{% for post in site.categories.stats_ps %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>

#### neural_networks
<ul class="post-list">
	{% for post in site.categories.NN_ps %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>

#### reinforcement_learning
<ul class="post-list">
	{% for post in site.categories.RL_ps %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>

#### differential_privacy
<ul class="post-list">
	{% for post in site.categories.DP_ps %}
	<li>
		<span>{{ post.date | date: "%b %d, %Y" }}</span>
		<a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
	</li>
	{% endfor %}
</ul>
