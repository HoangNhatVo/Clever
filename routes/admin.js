var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.render('admin/account', { layout: 'admin' });
});

router.get('/course', function (req, res, next) {
  res.render('admin/course', { layout: 'admin' });
});

module.exports = router;
