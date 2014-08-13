<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewpoart" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		{% include './styles.swig' ignore missing %}
		{% block head %}
		{% endblock %}
	</head>
	<body>
		{% include './header.swig' ignore missing %}
		{% block body %}{% endblock %}
		{% include './footer.swig' ignore missing %}
		{% include './scripts.swig' ignore missing %}
	</body>
</html>