var orm = require('../config/orm')
module.exports = {
    allCourse: (limit, index) => {
        return orm.selectAll(`call GetListCourse(${limit},${index})`);
    }
};