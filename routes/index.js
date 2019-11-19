var express = require('express');
var router = express.Router();
<<<<<<< Updated upstream
=======
var indexModel = require('../proc/index.model');
var courseModel = require('../proc/course.model');

var passport = require('passport');
var bCrypt = require('bcrypt');
>>>>>>> Stashed changes

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
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
router.get('/courses',function(req,res,next){
  res.render('courses')
})


router.get('/single-course/:ID',function(req,res,next){
  var ID = req.params.ID;
  courseModel.detailCourse(ID).then(course=>{
    res.render('single-course',{course});
  }).catch(err=>{
    console.log(err);
  })
})
router.get('/instructor',function(req,res,next){
  res.render('instructor')
})
router.get('/login',function(req,res,next){
  res.render('./login/index')
})
router.get('/register',function(req,res,next){
  res.render('./register/index')
})
module.exports = router;
