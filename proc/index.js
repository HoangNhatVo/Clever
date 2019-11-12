var orm = require('./config/orm')
module.export = {
    allCourse: () => {
        return orm.selectAll('call abc');
    }
}