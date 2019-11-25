var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser');
var exphbs = require('express-handlebars');
var indexRouter = require('./routes/index');
var adminRouter = require('./routes/admin');
require('./config/connection')
var app = express();

var express_handlebars_sections = require('express-handlebars-sections');

var Passport = require('passport');
var flash = require('connect-flash');
var localStrategy = require('passport-local').Strategy;
var session = require('express-session');
require('./MiddleWares/passport')(Passport);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
  defaultLayout: 'layout',
  layoutsDir: path.join(__dirname, 'views/layout'),
  partialsDir: path.join(__dirname, 'views/partial'),
  extname: '.hbs',
  helpers: {
    section: express_handlebars_sections(),
    selected: (option, value) => {
      if (option === value) {
        return ' selected';
      } else {
        return ''
      }
    }
  }
}));
app.set('view engine', 'hbs');


app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
  secret: "mysecret", resave: true, saveUninitialized: true,
  cookie: {
    maxAge: 1000 * 60 * 3
  }
}));
app.use(Passport.initialize());
app.use(Passport.session());
app.use(flash());

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(require('./MiddleWares/auth_locals.mdw'));
app.use(require('./MiddleWares/local.mdw'));

app.use('/', indexRouter);
app.use('/admin', adminRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
