// Generated by LiveScript 1.2.0
var fs, swig, express, compression, responseTime, request, crypto, argv, yaml, app, cachekey, start, blog, x$;
fs = require('fs');
swig = require('swig');
express = require('express');
compression = require('compression');
responseTime = require('response-time');
request = require('request');
crypto = require('crypto');
argv = require('yargs').argv;
yaml = require('js-yaml');
app = express();
start = new Date(Date.now()).toString();
app.locals.cachekey = crypto.createHash('sha512').update(start).digest('base64');
app.engine('swig', swig.renderFile).set('view engine', 'swig').set('views', __dirname + '/views').use(compression()).use(responseTime()).disable('x-powered-by').use('/assets', express['static'](__dirname + '/assets')).use(function(req, res, next){
  if (/mobile/i.test(req.header('user-agent'))) {
    req.ismobile = true;
  } else {
    req.ismobile = false;
  }
  return next();
});
blog = yaml.safeLoad(fs.readFileSync('./blog.yaml', 'utf8'));
x$ = app;
x$.route('/').get(function(req, res, next){
  if (req.ismobile) {
    return next();
  } else {
    res.locals.blog = blog;
    return res.render('index');
  }
}).get(function(req, res, next){
  var short, i$, ref$, len$, x;
  res.locals.links = blog;
  short = [];
  for (i$ = 0, len$ = (ref$ = [0, 1, 2, 3, 4, 5, 6, 7]).length; i$ < len$; ++i$) {
    x = ref$[i$];
    short.push(blog[x]);
  }
  res.locals.blog = short;
  return res.render('m/index');
});
x$.route('/:date').get(function(req, res, next){
  var date, i$, ref$, len$, entry;
  if (res.ismobile) {
    return next('route');
  } else {
    res.locals.links = blog;
    date = [];
    for (i$ = 0, len$ = (ref$ = blog).length; i$ < len$; ++i$) {
      entry = ref$[i$];
      if (entry.date === req.params.date) {
        date.push(entry);
      }
    }
    res.locals.blog = date;
    return res.render('index');
  }
}).get(function(req, res, next){
  var date, i$, ref$, len$, entry;
  res.locals.links = blog;
  date = [];
  for (i$ = 0, len$ = (ref$ = blog).length; i$ < len$; ++i$) {
    entry = ref$[i$];
    if (entry.date === req.params.date) {
      date.push(entry);
    }
  }
  res.locals.blog = date;
  return res.render('m/index');
});
x$.listen(Number(process.env.PORT || argv.http || 1337));