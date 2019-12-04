// tú
var orm = require('../config/orm')
module.exports = {
    detailCourse: (ID) => {
        return orm.selectAll(`call GetCourseDetail(${ID})`)
    },
    buyCourse: (studentid,courseid) => {
        return orm.selectAll(`call BuyCourse(${studentid},${courseid})`)
    }
};