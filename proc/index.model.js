var orm = require('../config/orm')
module.exports = {
    allCourse: (page) => {
        return orm.selectAll(`call GetListCourse(${page})`);
    },
    allSubject: () => {
    return orm.selectAll(`call GetListSubject()`)
    }
};