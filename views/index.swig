{% extends './html.swig' %}
{% set title = "gabe.io - Home" %}



{% block head %}
	<title>{{title}}</title>
	<meta name="description" content="Just a small blog for a small site.">
{% endblock %}



{% block body %}
<div class="row">
	<div class="col-md-3 pull-right">
		<ul class="list-unstyled">
			{% for entry in links %}
				{% if entry.date != last %}
					{% if !loop.first %}
				</ul></li>
					{% endif %}
			</li>
			<li>
				<h4>{{ entry.date }}</h4>
				<ul class="list-group">
				{% endif%}
				{% set last = entry.date %}
				{% if loop.index < 25 and full %}
						<a class="list-group-item" href="#{{ entry.title|safe }}">{{ entry.title }}</a>
				{% else %}
						<a class="list-group-item" href="/d/{{ entry.date|safe }}">{{ entry.title }}</a>
				{% endif %}
			{% endfor %}
		</ul>
		<h5>Tags</h5>
		<ul class="list-unstyled list-group">
			{% for tag,entry in tags %}
			<li><a class="list-group-item" href="/t/{{ tag }}">{{ tag }}</a></li>
			{% endfor %}
		</ul>
	</div>
	<div class="col-md-9">
		<div class="row">
			{% if !entries %}
			{% set entries = blog %}
			{% endif %}
			{% for entry in entries %}
				{% if loop.index < 25 or search %}
					{% if entry.content and !entry.private %}
						{% if !loop.first %}
			<div class="col-md-12"><hr /></div>
						{% endif %}
			<div class="col-md-12" id="{{ entry.title }}">
				<div class="row">
					<div class="col-md-12">
						<h3>{{ entry.title|safe }}</h3>
						{{ entry.content|safe }}
					</div>
				</div>
				<br />
				<div class="row">
					<div class="col-md-6 pull-left">
						<span class="pull-left">
						<label>Date: </label> {{ entry.date }}
						</span>
					</div>
					<div class="col-md-6 pull-right">
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