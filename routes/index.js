var express = require('express');
var router = express.Router();

var indexModel = require('../proc/index.model');
var courseModel = require('../proc/course.model');

var passport = require('passport');
var bCrypt = require('bcrypt');
var indexModel = require('../proc/index.model');

var passport = require('passport');
var bCrypt = require('bcrypt');

/* GET home page. */
router.get('/', async function(req, res, next) {
  try {
    var listCourse = await indexModel.allCourse(1)
    var listSubject = await indexModel.allSubject()
    res.render('index',
    {
      listCourse,
      listSubject
    });
  } catch (error) {
    console.log(error)
  }

});

router.get('/blog', function(req, res, next) {
  res.render('blog')
})

router.get('/contact', function(req,res, next){
  res.render('contact')
})
router.get('/blog-detail', function(req,res,next){
  res.render('blog-detail')
})
router.get('/courses',async function(req,res,next){
  try {
    var listCourse = await indexModel.allCourse(1)
    res.render('courses',
    {
      listCourse
    });
  } catch (error) {
    console.log(error)
  }
})


router.get('/single-course/:ID',async function(req,res){
  try {
    var ID =req.params.ID;
    var course = await courseModel.detailCourse(ID);
    res.render('single-course',
    {
      course
    });
  } catch (error) {
    console.log(error)
  }
})
router.get('/instructor',function(req,res,next){
  res.render('instructor')
})

router.get('/profile',function(req,res,next){
  res.render('profile')
})

// Đăng nhập
router.get('/login',function(req,res,next){
  if(!req.isAuthenticated() || req.user == true){
    req.logout();
    req.session.cookie.expires = false;
    res.render('./login',{message: req.flash('loginMessage')})
  }
  else{
    res.redirect('/');
  }
})

router.post('/login', passport.authenticate('local-login', {
  failureRedirect: '/login',
  successRedirect: '/',
  failureFlash: true
}),
  function (req, res) {
    if (req.body.remember) {
      req.session.cookie.maxAge = 1000 * 60 * 3;
    }
    else {
      req.session.cookie.expires = false;
    }
    res.redirect('/');
  }
);

// Đăng kí
router.get('/register',function(req,res,next){
  if(!req.isAuthenticated()){
    res.render('./register',{message: req.flash('registerMessage')})
  }
  else{
    res.redirect('/');
  }
})

//router dang ky
router.post('/register', passport.authenticate('local-signup', {
  failureRedirect: '/register',
  successRedirect: '/login',
  failureFlash: true
}),
  function (req, res) {}
);

//Đăng xuất
router.post('/logout', function (req, res) {
  req.logout();
  req.session.cookie.expires = false;
  res.redirect('/');
});


module.exports = router;
