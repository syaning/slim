---
layout: page
title: paper_summaries
---
It's easy for me to forget the contents of a paper after I've read it. In light of this,
I thought it'd be a good idea to start summarizing the *"Why?"*, *"How?"*, and *"What?"*
of the research papers that I come across. The point here is to write these summaries
so that they are short enough that I wouldn't mind re-reading them on an occasional
basis, while also being thorough enough for me to be able to recall the main arguments, methods,
and results of the research.

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
