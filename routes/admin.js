var express = require('express');
var router = express.Router();
var adminModel = require('../proc/admin.model');
var moment = require('moment');

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.render('admin/account', { layout: 'admin' });
});

router.get('/course', async function (req, res, next) {
  if (req.query.id) {
    try {
      const courseDetail = await adminModel.getOne('courses', 'course_id', req.query.id);
      const listSubject = await adminModel.findAll('subjects');
      console.log(courseDetail)
      courseDetail.course_start_date = moment(courseDetail.course_start_date).format('YYYY-MM-DD');
      courseDetail.course_end_date = moment(courseDetail.course_end_date).format('YYYY-MM-DD');
      res.render('admin/detail',
        {
          layout: 'admin',
          courseDetail,
          listSubject
        });
    } catch (error) {
      console.log(error)
    }
  } else {
    try {
      const listCourse = await adminModel.findAll('courses');
      const listSubject = await adminModel.findAll('subjects');
      res.render('admin/course',
        {
          layout: 'admin',
          listCourse,
          listSubject
        });
    } catch (error) {
      console.log(error)
    }
  }
});

router.post('/course/create', async function (req, res, next) {
  try {
    const { name, subject, startDate, endDate, price, description } = req.body;
    await adminModel.createOne('courses', {
      courses_status: 'active',
      course_name: name,
      course_subject: subject,
      course_start_date: startDate,
      course_end_date: endDate,
      course_price: price,
      course_description: description
    });
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
});

router.post('/course/update', async function(req, res, next) {
  try {
    const { id ,name, subject, startDate, endDate, price, description } = req.body;
    await adminModel.updateOne('courses', 'course_id' , {
      course_id: id,
      course_name: name,
      course_subject: subject,
      course_start_date: startDate,
      course_end_date: endDate,
      course_price: price,
      course_description: description
    });
    res.redirect('/admin/course?id='+id)
  } catch (error) {
    console.log(error)
  }
})

router.post('/course/delete', async function(req, res, next) {
  try {
    const { id } = req.body;
    await adminModel.deleteOne('courses', 'course_id' , id);
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
})

module.exports = router;
