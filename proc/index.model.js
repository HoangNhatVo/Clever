var orm = require('../config/orm')
module.exports = {
    allCourse: () => {
        return orm.selectAll(`call GetActiveCourseList()`);
    },
    allSubject: () => {
    return orm.selectAll(`call GetListSubject()`)
    },
    allCoursebySubject : (subId) =>{
        return orm.selectAll(`call GetActiveCourseListBySubject(${subId})`)
    },
    getSubjectById: (Id) => {
        return orm.selectAll(`call GetSubjectByID(${Id})`)
    }
};