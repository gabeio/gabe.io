// Generated by LiveScript 1.4.0
var start, compression, crypto, express, fs, helmet, jsYaml, responseTime, swig, yargs, argv, app, cachekey, blog, titles, i$, len$, entry, dates, tags, j$, ref$, len1$, tag, x$;
start = new Date(Date.now()).toString();
compression = require('compression');
crypto = require('crypto');
express = require('express');
fs = require('fs');
helmet = require('helmet');
jsYaml = require('js-yaml');
responseTime = require('response-time');
swig = require('swig');
yargs = require('yargs');
argv = yargs.argv;
app = express();
app.locals.cachekey = crypto.createHash('sha512').update(start).digest('base64');
app.engine("swig", swig.renderFile).set("view engine", "swig").use(helmet()).use(helmet.contentSecurityPolicy({
  defaultSrc: ["\"self\"", "maxcdn.bootstrapcdn.com", "cdnjs.cloudflare.com"],
  scriptSrc: ["\"self\"", "maxcdn.bootstrapcdn.com", "cdnjs.cloudflare.com"],
  styleSrc: ["\"self\"", "maxcdn.bootstrapcdn.com", "cdnjs.cloudflare.com", "fonts.googleapis.com"],
  fontSrc: ["\"self\"", "maxcdn.bootstrapcdn.com", "cdnjs.cloudflare.com", "fonts.googleapis.com", "fonts.gstatic.com"]
})).use(helmet.frameguard("deny")).use(compression()).use(responseTime()).use("/assets", express['static'](__dirname + "/assets")).use(function(req, res, next){
  if (/mobile/i.test(req.header("user-agent"))) {
    req.ismobile = true;
  } else {
    req.ismobile = false;
  }
  res.locals.url = req.url;
  return next();
});
blog = jsYaml.safeLoad(fs.readFileSync('./blog.yaml', 'utf8'));
app.locals.blog = blog;
app.locals.links = blog;
titles = {};
for (i$ = 0, len$ = blog.length; i$ < len$; ++i$) {
  entry = blog[i$];
  titles[entry.title] = entry;
}
app.locals.titles = titles;
dates = {};
for (i$ = 0, len$ = blog.length; i$ < len$; ++i$) {
  entry = blog[i$];
  if (dates[entry.date] == null) {
    dates[entry.date] = [];
  }
  dates[entry.date].push(entry);
}
app.locals.dates = dates;
tags = {};
for (i$ = 0, len$ = blog.length; i$ < len$; ++i$) {
  entry = blog[i$];
  if (entry.tags != null) {
    for (j$ = 0, len1$ = (ref$ = entry.tags).length; j$ < len1$; ++j$) {
      tag = ref$[j$];
      if (tags[tag] == null) {
        tags[tag] = [];
      }
      tags[tag].push(entry);
    }
  }
}
app.locals.tags = tags;
x$ = app;
x$.route("/").get(function(req, res, next){
  if (req.ismobile) {
    return next();
  } else {
    res.locals.full = true;
    return res.render("index");
  }
}).get(function(req, res, next){
  res.locals.entries = blog;
  return res.render("m/index");
});
x$.route("/t/:tag").get(function(req, res, next){
  if (req.ismobile) {
    return res.redirect("/");
  } else {
    res.locals.entries = tags[req.params.tag];
    return res.render("index");
  }
});
x$.route("/d/:date").get(function(req, res, next){
  if (req.ismobile) {
    return res.redirect("/");
  } else {
    res.locals.entries = dates[req.params.date];
    return res.render("index");
  }
});
x$.route("/e/:title").get(function(req, res, next){
  if (!req.ismobile) {
    return next("route");
  } else {
    res.locals.entry = titles[req.params.title];
    return res.render("m/entry");
  }
});
x$.listen(Number(process.env.PORT || argv.http || 1337));