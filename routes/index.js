var express = require('express');
var router = express.Router();

var indexModel = require('../proc/index.model');
var courseModel = require('../proc/course.model');
var rechargeModel = require('../proc/recharge.model')
var passport = require('passport');
var bCrypt = require('bcrypt');
var indexModel = require('../proc/index.model');
<<<<<<< Updated upstream
var profileModel=require('../proc/account.model')
=======
var profileModel = require('../proc/account.model')
var accountModel=require('../proc/account.model')
>>>>>>> Stashed changes

var passport = require('passport');
var bCrypt = require('bcrypt');

/* GET home page. */
router.get('/', async function(req, res, next) {
  try {
    var listCourse = await indexModel.allCourse(1)
    var listSubject = await indexModel.allSubject()
    var listInstructor = await accountModel.getListTeacher();
    console.log(listInstructor);
    res.render('index',
<<<<<<< Updated upstream
    {
      listCourse,
      listSubject
    });
=======
      {
        listCourse,
        listSubject,
        listInstructor
      });
>>>>>>> Stashed changes
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

router.get('/recharge', async function(req,res,next){
  if(req.user)
  {
  res.render('recharge')
  }
  else {
    res.redirect('/login')
  }
})

router.post('/recharge', async function(req,res,next){
  try{
    var ID = req.user.account_id
    var type =  req.body.homenetwork;
    var amount = parseInt(req.body.denominations)
    console.log(ID,type,amount)
    var recharge = await rechargeModel.rechargeMoney(ID,type,amount)
    res.render('recharge-sucess')
  }
  catch (error){
    res.send('error')
  }
})

router.get('/course/:ID',async function(req,res,next){
  try {
    var ID =req.params.ID
    var listCoursebySub = await indexModel.allCoursebySubject(1,ID)
    var Subject = await indexModel.getSubjectById(ID)
    console.log(Subject)
    res.render('course',
    {
      listCoursebySub,
      Subject
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
<<<<<<< Updated upstream
router.get('/instructor',function(req,res,next){
  res.render('instructor')
=======
router.get('/instructor', async function (req, res, next) {
  try {
    var listInstructor = await accountModel.getListTeacher();
    res.render('instructor',
      {
        listInstructor
      });
  } catch (error) {
    console.log(error)
  }
>>>>>>> Stashed changes
})

router.get('/profile',async function(req,res,next){
  try {
    var ID =req.user.account_id;
    var user = await profileModel.getAccountDetails(ID);
    if(user[0].balance===null) user[0].balance=0;
    res.render('profile', 
    {
      user
    });
  } catch (error) {
    console.log(error)
  }
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
