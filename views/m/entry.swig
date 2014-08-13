{% extends './html.swig' %}
{% set title = entry.title%}



{% block head %}
<title>{{title}}</title>
<meta name="description" content="Just a small blog for a small site.">
{% endblock %}



{% block body -%}
<div class="content-padded">
	{{entry.content|safe}}
</div>
{%- endblock %}