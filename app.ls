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
	res.locals.url = req.url
	next()


blog = yaml.safeLoad fs.readFileSync \./blog.yaml, \utf8
app.locals.blog = blog
app.locals.links = blog

titles = {}
for entry in blog
	titles[entry.title] = entry
app.locals.titles = titles

dates = {}
for entry in blog
	if !dates[entry.date]?
		dates[entry.date] = []
	dates[entry.date].push entry
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
		res.locals.entries = blog
		res.render 'm/index'

	# get specific tag
	..route '/t/:tag'
	.get (req,res,next)->
		if req.ismobile
			res.redirect '/'
		else
			res.locals.entries = tags[req.params.tag]
			res.render 'index'

	# get specific date
	..route '/d/:date'
	.get (req,res,next)->
		if req.ismobile
			res.redirect '/'
		else
			res.locals.entries = dates[req.params.date]
			res.render 'index'

	# get single entry
	..route '/e/:title'
	.get (req,res,next)->
		if !req.ismobile
			next('route') # error
		else
			res.locals.entry = titles[req.params.title]
			res.render 'm/entry'

	..listen Number process.env.PORT || argv.http || 1337
