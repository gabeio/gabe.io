{% extends './html.swig' %}
{% set title = "gabe.io - Home" %}



{% block head %}
	<title>{{title}}</title>
	<meta name="description" content="Just a small blog for a small site.">
{% endblock %}



{% block body %}
<div class="row">
	<div class="col-md-2 pull-right">
		<div class="hidden-sm">
			<ul class="list-unstyled">
				{% if !links %}
					{% set links = blog %}
				{% endif %}
				{% for entry in links %}
					{% if entry.date != last %}
						{% if !loop.first %}
					</ul><li class="divider"></li>
						{% endif %}
				</li>
				<li>
					<h4>{{ entry.date }}</h4>
					<ul class="list-group">
					{% endif%}
					{% set last = entry.date %}
						{#<li class="list-group-item">#}
					{% if loop.index < 25 and !full %}
							<a class="list-group-item" href="#{{ entry.title }}">{{ entry.title }}</a>
					{% else %}
							<a class="list-group-item" href="/blog/{{ entry.date }}">{{ entry.title }}</a>
					{% endif %}
						{#</li>#}
				{% endfor %}
			</ul>
		</div>
	</div>
	<div class="col-md-9">
		<div class="row">
			{% for entry in blog %}
				{% if loop.index < 15 or search %}
					{% if entry.content and !entry.private %}
						{% if !loop.first %}
			<div class="col-md-12"><hr /></div>
						{% endif %}
			<div class="col-md-12" id="{{ entry.title }}">
				<div class="row">
					<div class="col-sm-12">
						<h3>{{ entry.title }}</h3>
						{{ entry.content|safe }}
					</div>
				</div>
				<br />
				<div class="row">
					<div class="col-sm-3 pull-left">
						<span class="pull-left">
						<label>Date: </label> {{ entry.date }}
						</span>
					</div>
					<div class="col-sm-3 pull-right">
						<span class="pull-right">
							<label>Author: </label> {{ entry.author }}
						</span>
					</div>
				</div>
			</div>
					{% endif %}{# end !private? #}
				{% endif %}{# end < 15 #}
			{% endfor %}
		</div>
	</div>
</div>
{% endblock %}