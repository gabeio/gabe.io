name: 'gabe.io'

version: '0.1.0'

description: 'just a small blog for my small site'

author: 'Gabe De <gabe@shov.me>'

homepage: 'http://gabe.io'

bugs: 'https://github.com/gabeio/gabe.io/issues'

licenses:
	type: 'MIT', url: 'https://raw.githubusercontent.com/gabeio/gabe.io/master/LICENSE'
	...

engines:
	node: '>= 0.10.0'

main: './app.ls'

scripts:
	build: 'livescript -cb *.ls'
	start: 'node app.js'

repository:
	type: 'git'
	url: 'git://github.com/gabeio/gabe.io.git'

dependencies:
	express: '4.8.x'
	yargs: '1.3.x'
	swig: '1.4.x'
	compression: '1.0.x'
	'js-yaml': '3.1.x'
	LiveScript: '1.2.x'
	'response-time': '2.0.x'