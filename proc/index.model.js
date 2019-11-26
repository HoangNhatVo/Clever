var orm = require('../config/orm')
module.exports = {
    allCourse: (page) => {
        return orm.selectAll(`call GetActiveCourseList(${page})`);
    },
    allSubject: () => {
    return orm.selectAll(`call GetListSubject()`)
    },
    allCoursebySubject : (page,subId) =>{
        return orm.selectAll(`call GetActiveCourseListBySubject(${page},${subId})`)
    },
    getSubjectById: (Id) => {
        return orm.selectAll(`call GetSubjectByID(${Id})`)
    }
};