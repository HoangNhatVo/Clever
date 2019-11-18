var express = require('express');
var router = express.Router();
var indexModel = require('../proc/index.model');

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.render('admin/account', { layout: 'admin' });
});

router.get('/course', async function (req, res, next) {
  // try {
  //   var listCourse = await indexModel.allCourse(1)
  //   var listSubject = await indexModel.allSubject()
  //   res.render('admin/course',
  //   {
  //     layout: 'admin.hbs',
  //     listCourse,
  //     listSubject
  //   });
  // } catch (error) {
  //   console.log(error)
  // }
  res.render('admin/course',{layout: 'admin'})
});

router.post('/course', async function (req, res, next) {
  console.log(req.body)
  res.redirect('course')
});

module.exports = router;
