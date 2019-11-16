var express = require('express');
var router = express.Router();
var indexModel = require('../proc/index.model');
/* GET home page. */
router.get('/', async function(req, res, next) {
  try {
    var listCourse = indexModel.allCourse(10,0)
    console.log(listCourse)
    res.render('index');
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
router.get('/courses',function(req,res,next){
  res.render('courses')
})
router.get('/single-course',function(req,res,next){
  res.render('single-course')
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
