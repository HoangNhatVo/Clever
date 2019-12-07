var express = require('express');
var router = express.Router();

var indexModel = require('../proc/index.model');
var courseModel = require('../proc/course.model');
var lessonModel = require('../proc/lesson.model')
var rechargeModel = require('../proc/recharge.model')
var passport = require('passport');
var bCrypt = require('bcrypt');
var indexModel = require('../proc/index.model');
var profileModel = require('../proc/account.model')

var auth = require('../MiddleWares/auth_student');

// var passport = require('passport');
// var bCrypt = require('bcrypt');
const saltRounds = 10;
/* GET home page. */
router.get('/', async function (req, res, next) {
  try {
    var listCourse = await indexModel.allCourse()
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

router.get('/blog', function (req, res, next) {
  res.render('blog')
})

router.get('/contact', function (req, res, next) {
  res.render('contact')
})
router.get('/blog-detail', function (req, res, next) {
  res.render('blog-detail')
})
router.get('/courses', async function (req, res, next) {
  try {
    var listCourse = await indexModel.allCourse()
    res.render('courses',
      {
        listCourse
      });
  } catch (error) {
    console.log(error)
  }
})


router.get('/recharge', auth, async function(req,res,next){
  if(req.user)
  {
  res.render('recharge')
  }
  else {
    res.redirect('/login')
  }
})

router.post('/recharge', async function (req, res, next) {
  try {
    var ID = req.user.account_id
    var type = req.body.homenetwork;
    var amount = parseInt(req.body.denominations)
    console.log(ID, type, amount)
    var recharge = await rechargeModel.rechargeMoney(ID, type, amount)
    res.render('recharge-sucess')
  }
  catch (error) {
    res.send('error')
  }
})


router.get('/course/:ID', async function (req, res, next) {
  try {
    var ID = req.params.ID
    var listCoursebySub = await indexModel.allCoursebySubject(ID)
    var Subject = await indexModel.getSubjectById(ID)
    res.render('course',
      {
        listCoursebySub,
        Subject
      });
  } catch (error) {
    console.log(error)
  }
})

router.get('/single-course/:ID', async function (req, res) {
  try {
    var ID = req.params.ID;
    var course = await courseModel.detailCourse(ID);
    const lessons = await lessonModel.findAll('lessons', 'lesson_course', ID, 'lesson_week');
    const resources = await lessonModel.getAll('resources');
    res.render('single-course',
      {
        course: course[0],
        lessons,
        resources
      });
  } catch (error) {
    console.log(error)
  }
})
router.get('/instructor', function (req, res, next) {
  res.render('instructor')
})

router.get('/profile',auth, async function(req,res,next){
  try {
    var ID = req.user.account_id;
    var user = await profileModel.getAccountDetails(ID);
    if (user[0].balance === null) user[0].balance = 0;
    res.render('profile',
      {
        user
      });
  } catch (error) {
    console.log(error)
  }
})

// Đăng nhập
router.get('/login', function (req, res, next) {
  if (!req.isAuthenticated() || req.user == true) {
    req.logout();
    req.session.cookie.expires = false;
    res.render('./login', { message: req.flash('loginMessage') })
  }
  else {
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
router.get('/register', function (req, res, next) {
  if (!req.isAuthenticated()) {
    res.render('./register', { message: req.flash('registerMessage') })
  }
  else {
    res.redirect('/');
  }
})

//router dang ky
router.post('/register', passport.authenticate('local-signup', {
  failureRedirect: '/register',
  successRedirect: '/login',
  failureFlash: true
}),
  function (req, res) { }
);

//Đăng xuất
router.post('/logout', function (req, res) {
  req.logout();
  req.session.cookie.expires = false;
  res.redirect('/');
});


// Đổi mật khẩu
router.get('/changepassword', async function(req,res,next){
  if(req.isAuthenticated()){
    res.render('./change-password',{message: req.flash('changePasswordMessage')})
  }
  else{
    res.redirect('/login');
  }
})

router.post('/changepassword', function(req,res,next){
  var ID = req.user.account_id;
  var newPass = bCrypt.hashSync(req.body.newPassword, bCrypt.genSaltSync(saltRounds));
  profileModel.getAccountByID(ID).then(r=>{
    if(!r.length){
      req.flash('changePasswordMessage', 'Không tìm thấy người dùng.');
      res.redirect('/changepassword');
    }
    else{
      if(!bCrypt.compareSync(req.body.curPassword, r[0].account_password)){
        req.flash('changePasswordMessage', 'Nhập mật khẩu hiện tại không đúng.');
        res.redirect('/changepassword');
      }
      else{
        profileModel.updatePasswordAccountByID(ID, newPass).then(r1=>{
          req.logout();
          req.session.cookie.expires = false;
          res.redirect('/');
        }).catch(err=>{
          console.log(err);
          req.flash('changePasswordMessage', 'Đã xảy ra lỗi.');
          res.redirect('/changepassword');
        })
      }
    }
  }).catch(err=>{
    console.log(err);
    req.flash('changePasswordMessage', 'Đã xảy ra lỗi.');
    res.redirect('/changepassword');
  })
})
//Mua khóa học
router.post('/buycourse', async function (req, res) {
  if (!req.user)
    res.redirect('/login')
  else {
    try {
      const { id } = req.body
      var IDuser = req.user.account_id;
      var user = await profileModel.getAccountDetails(IDuser);
      var course = await courseModel.detailCourse(id);
      if (user[0].balance === null) user[0].balance = 0;
      if (user[0].balance < course[0].course_price)
        res.render('notification')
      else {
        console.log(IDuser,parseFloat(id))
        const buy = await courseModel.buyCourse(IDuser, parseFloat(id))
        res.redirect('/yourcourse')
      }
    }
    catch (err) {
      console.log(err)
    }
  }
})

router.get('/yourcourse', passport.authenticate('local-signup', {
  failureRedirect: '/register',
  successRedirect: '/login',
  failureFlash: true
}), async function(req,res){
  try {
    var stdId = req.user.account_id
    var listCourses = await indexModel.allCourseByStudentId(stdId)
    res.render('yourcourse',
      {
        listCoursesByStudentId: listCourses
      } );
  } catch (error) {
    console.log(error)
  }
})

module.exports = router;
