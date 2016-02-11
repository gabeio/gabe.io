name: "gabe.io"

version: "0.1.0"

description: "just a small blog for my small site"

author: "Gabe De <gabe@shov.me>"

homepage: "http://gabe.io"

bugs: "https://github.com/gabeio/gabe.io/issues"

licenses:
	type: "MIT", url: "https://raw.githubusercontent.com/gabeio/gabe.io/master/LICENSE"
	...

engines:
	node: ">= 0.10.0"

main: "./app.ls"

scripts:
	build: "livescript -cb *.ls"
	start: "node app.js"
	test: "nodeunit test"
	coveralls: "jscoverage lib && YOURPACKAGE_COVERAGE=1 nodeunit --reporter=lcov test | coveralls"

repository:
	type: "git"
	url: "git://github.com/gabeio/gabe.io.git"

dependencies:
	"compression": "1.0.x"
	"express": "4.13.x"
	"helmet": "1.1.x"
	"js-yaml": "3.1.x"
	"livescript": "1.4.x"
	"response-time": "2.0.x"
	"swig": "1.4.x"
	"yargs": "3.15.x"

devDependencies:
	"coveralls": "2.11.x"
	"jscoverage": "0.5.x"
	"nodeunit": "0.9.x"
