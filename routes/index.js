var express = require('express');
var router = express.Router();

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
router.get('/single-course',function(req,res,next){
  res.render('single-course')
})
router.get('/instructor',function(req,res,next){
  res.render('instructor')
})
module.exports = router;
