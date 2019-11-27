var express = require('express');
var router = express.Router();
var adminModel = require('../proc/admin.model');
var moment = require('moment');

//#region Account
router.get('/', function (req, res, next) {
  res.render('admin/account', { layout: 'admin' });
});
//#endregion

//#region Course
router.get('/course', async function (req, res, next) {
  if (req.query.id) {
    try {
      const courseDetail = await adminModel.getOne('courses', 'course_id', req.query.id);
      const listSubject = await adminModel.findAll('subjects');

      courseDetail.course_start_date = moment(courseDetail.course_start_date).format('YYYY-MM-DD');
      courseDetail.course_end_date = moment(courseDetail.course_end_date).format('YYYY-MM-DD');
      res.render('admin/course/detail',
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
      course_end_date: endDate ? endDate : null,
      course_price: price,
      course_description: description
    });
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
});

router.post('/course/update', async function (req, res, next) {
  try {
    const { id, name, subject, startDate, endDate, price, description } = req.body;
    await adminModel.updateOne('courses', 'course_id', {
      course_id: id,
      course_name: name,
      course_subject: subject,
      course_start_date: startDate,
      course_end_date: endDate,
      course_price: price,
      course_description: description
    });
    res.redirect('/admin/course?id=' + id)
  } catch (error) {
    console.log(error)
  }
})

router.post('/course/delete', async function (req, res, next) {
  try {
    const { id } = req.body;
    await adminModel.deleteAll('courses', 'course_id', id);
    res.redirect('/admin/course')
  } catch (error) {
    console.log(error)
  }
})
//#endregion

router.get('/lesson', async function (req, res, next) {
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
    const { title, course, status, content, resourceName, resourceType, resourceUrl } = req.body;
    const lesson_id = await adminModel.createOne('lessons', {
      lesson_status: status,
      lesson_title: title,
      lesson_course: course,
      lesson_content: content
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
    const { id, title, status, course, content, resourceName, resourceType, resourceUrl } = req.body;

    await adminModel.updateOne('lessons', 'lesson_id', {
      lesson_id: id,
      lesson_status: status,
      lesson_course: course,
      lesson_title: title,
      lesson_content: content
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
