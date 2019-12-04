var express = require('express');
var router = express.Router();
var adminModel = require('../proc/admin.model');
var moment = require('moment');

var isAdministrator = require('../MiddleWares/auth_administrator');
var isAdmin = require('../MiddleWares/auth_admin');
//#region Account
router.get('/', isAdmin, function (req, res, next) {
  res.render('admin/account', { layout: 'admin' });
});
//#endregion

//#region Course
router.get('/course', isAdmin, async function (req, res, next) {
  if (req.query.id) {
    try {
      const courseDetail = await adminModel.executeQuery(`select * from courses, co_ac where course_id = ${req.query.id} and course_id = co_ac_course`);
      const listSubject = await adminModel.findAll('subjects');
      const listTeacher = await adminModel.executeQuery(`select * from accounts where account_role = 'teacher'`);
      console.log(courseDetail)

      courseDetail[0].course_start_date = moment(courseDetail.course_start_date).format('YYYY-MM-DD');
      courseDetail[0].course_end_date = moment(courseDetail.course_end_date).format('YYYY-MM-DD');
      res.render('admin/course/detail',
        {
          layout: 'admin',
          courseDetail: courseDetail[0],
          listSubject,
          listTeacher
        });
    } catch (error) {
      console.log(error)
    }
  } else {
    try {
      const listCourse = await adminModel.executeQuery(` select * from courses join accounts join co_ac join subjects where course_subject = subject_id and course_id = co_ac_course and co_ac_account = account_id and co_ac_role = 'teacher'`);
      const listSubject = await adminModel.findAll('subjects');
      const listTeacher = await adminModel.executeQuery(`select * from accounts where account_role = 'teacher'`)
      res.render('admin/course',
        {
          layout: 'admin',
          listCourse,
          listSubject,
          listTeacher
        });
    } catch (error) {
      console.log(error)
    }
  }
});

router.post('/course/create', async function (req, res, next) {
  try {
    const { name, status, subject, startDate, endDate, price, description, banner, teacher } = req.body;
    const course_id = await adminModel.createOne('courses', {
      courses_status: status,
      course_name: name,
      course_subject: subject,
      course_start_date: startDate,
      course_end_date: endDate ? endDate : null,
      course_price: price,
      course_description: description,
      course_banner: banner
    });
    await adminModel.createOne('co_ac',{
      co_ac_account: teacher,
      co_ac_course: course_id,
      co_ac_role: 'teacher'
    })
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
});

router.post('/course/update', async function (req, res, next) {
  try {
    const { id, name, status, subject, startDate, endDate, price, description, banner, teacher } = req.body;
    await adminModel.updateOne('courses', 'course_id', {
      course_id: id,
      courses_status: status,
      course_name: name,
      course_subject: subject,
      course_start_date: startDate,
      course_end_date: endDate,
      course_price: price,
      course_description: description,
      course_banner: banner
    });
    await adminModel.updateOne('co_ac', 'co_ac_course' , {
      co_ac_course: id,
      co_ac_account: teacher,
      co_ac_role: 'teacher'
    })
    res.redirect('/admin/course?id=' + id)
  } catch (error) {
    console.log(error)
  }
})

router.post('/course/delete', async function (req, res, next) {
  try {
    const { id } = req.body;
    await adminModel.deleteAll('co_ac', 'co_ac_course' , id)
    await adminModel.deleteAll('courses', 'course_id', id);
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
})
//#endregion

router.get('/lesson', isAdmin, async function (req, res, next) {
  if (req.query.id) {
    try {
      const lessonDetail = await adminModel.getOne('lessons', 'lesson_id', req.query.id);
      const listCourse = await adminModel.findAll('courses');
      const listResource = await adminModel.getAll('resources', 'resource_lesson', lessonDetail.lesson_id);

      res.render('admin/lesson/detail',
        {
          layout: 'admin',
          lessonDetail,
          listCourse,
          listResource
        });
    } catch (error) {
      console.log(error)
    }
  } else {
    try {
      const listLesson = await adminModel.executeQuery('select * from lessons, courses where lesson_course = course_id');
      const listCourse = await adminModel.findAll('courses');
      res.render('admin/lesson', { listLesson, listCourse, layout: 'admin' });
    } catch (error) {
      console.log(error)
    }
  }
});

router.post('/lesson/create', async function (req, res, next) {
  try {
    const { title, course, status, content, week, resourceName, resourceType, resourceUrl } = req.body;
    const lesson_id = await adminModel.createOne('lessons', {
      lesson_status: status,
      lesson_title: title,
      lesson_course: course,
      lesson_content: content,
      lesson_week: week
    })

    if (resourceName) {
      for (let i = 0; i < resourceName.length; i++) {
        await adminModel.createOne('resources', {
          resource_name: resourceName[i],
          resource_url: resourceUrl[i],
          resource_type: resourceType[i],
          resource_lesson: lesson_id
        })
      }
    }

    res.redirect('/admin/lesson')
  } catch (error) {
    console.log(error)
  }
});

router.post('/lesson/update', async function (req, res, next) {
  try {
    const { id, title, status, course, content, week, resourceName, resourceType, resourceUrl } = req.body;

    await adminModel.updateOne('lessons', 'lesson_id', {
      lesson_id: id,
      lesson_status: status,
      lesson_course: course,
      lesson_title: title,
      lesson_content: content,
      lesson_week: week
    });

    await adminModel.deleteAll('resources', 'resource_lesson', id);

    if (resourceName) {
      for (let i = 0; i < resourceName.length; i++) {
        await adminModel.createOne('resources', {
          resource_name: resourceName[i],
          resource_url: resourceUrl[i],
          resource_type: resourceType[i],
          resource_lesson: id
        })
      }
    }

    res.redirect('/admin/lesson?id=' + id)
  } catch (error) {
    console.log(error)
  }
})

router.post('/lesson/delete', async function (req, res, next) {
  try {
    const { id } = req.body;
    await adminModel.deleteAll('resources', 'resource_lesson', id);
    await adminModel.deleteAll('lessons', 'lesson_id', id);
    res.redirect('/admin/lesson')
  } catch (error) {
    console.log(error)
  }
})


module.exports = router;
