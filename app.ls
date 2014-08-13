#!/usr/env lsc

require! <[ fs swig express compression response-time crypto ]>
require! yargs.argv
yaml = require \js-yaml
app = express()
var cachekey
start = new Date Date.now() .toString()
app.locals.cachekey = crypto.createHash \sha512 .update start .digest \base64
# swig template engine
# compress output
# response-time should be interesting
# disable powered-by
app
.engine \swig, swig.renderFile
.set 'view engine', \swig
.set \views, __dirname+\/views
.use compression()
.use response-time()
.disable \x-powered-by
.use '/assets', express.static __dirname + '/assets'
.use (req,res,next)->
	if /mobile/i.test req.header('user-agent')
		req.ismobile = true
	else
		req.ismobile = false
	next()


blog = yaml.safeLoad fs.readFileSync \./blog.yaml, \utf8
app.locals.blog = blog
app.locals.links = blog

dates = {}
for entry in blog
	console.log entry.date
	if !dates[entry.date]?
		dates[entry.date] = []
	dates[entry.date].push entry
console.log JSON.stringify dates
app.locals.dates = dates

tags = {}
for entry in blog when entry.tags?
	for tag in entry.tags
		if !tags[tag]?
			tags[tag] = []
		tags[tag].push entry
app.locals.tags = tags

app
	..route '/'
	.get (req,res,next)->
		if req.ismobile
			next()
		else
			res.locals.full = true
			res.render 'index'
	# mobile load max 7
	.get (req,res,next)->
		short = []
		for x in [0 to 7]
			short.push blog[x]
		res.locals.entries = short
		res.render 'm/index'


	# get specific tag
	..route '/t/:tag'
	.get (req,res,next)->
		if req.ismobile
			next('route')
		else
			res.locals.entries = tags[req.params.tag]
			res.render 'index'
	.get (req,res,next)->
		res.locals.entries = tags[req.params.tag]
		res.render 'm/index'


	# get specific date
	..route '/d/:date'
	.get (req,res,next)->
		if req.ismobile
			next('route')
		else
			res.locals.entries = dates[req.params.date]
			res.render 'index'
	.get (req,res,next)->
		res.locals.entries = dates[req.params.date]
		res.render 'm/index'

	..listen Number process.env.PORT || argv.http || 1337
