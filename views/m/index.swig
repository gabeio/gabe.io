{% extends './html.swig' %}
{% set title = "gabe.io" %}



{% block head %}
<title>{{title}}</title>
<meta name="description" content="Just a small blog for a small site.">
{% endblock %}



{% block body -%}
<div class="card">
	<ul class="table-view">
		{% for entry in entries %}
		<li class="table-view-cell">
			<a class="navigate-right" href="/e/{{ entry.title }}" data-transition="slide-in">
				{{ entry.title }}
			</a>
		</li>
		{% endfor %}
	</ul>
</div>
{%- endblock %}