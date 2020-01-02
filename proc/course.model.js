// tú
var orm = require('../config/orm')
module.exports = {
    detailCourse: (ID) => {
        return orm.selectAll(`call GetCourseDetail(${ID})`)
    },
    buyCourse: (studentid,courseid) => {
        return orm.selectAll(`call BuyCourse(${studentid},${courseid})`)
    },
    loadCourseByUser: (courseId, userId) =>{
        return orm.load(`select * from co_ac where co_ac_course = ${courseId} and co_ac_account = ${userId}`)
    }
};