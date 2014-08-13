#!/usr/env lsc

require! <[ fs swig express compression response-time request crypto ]>
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

app
	..route '/'
	.get (req,res,next)->
		if req.ismobile
			next()
		else
			res.locals.blog = blog
			res.render 'index'
	# mobile load max 7
	.get (req,res,next)->
		res.locals.links = blog
		short = []
		for x in [0 to 7]
			short.push blog[x]
		res.locals.blog = short
		res.render 'm/index'
	# get specific date
	..route '/:date'
	.get (req,res,next)->
		if res.ismobile
			next('route')
		else
			res.locals.links = blog
			date = []
			for entry in blog
				if entry.date is req.params.date
					date.push entry
			res.locals.blog = date
			res.render 'index'
	.get (req,res,next)->
		res.locals.links = blog
		date = []
		for entry in blog when entry.date is req.params.date
			date.push entry
		res.locals.blog = date
		res.render 'm/index'

	..listen Number process.env.PORT || argv.http || 1337