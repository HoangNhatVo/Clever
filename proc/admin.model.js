var orm = require('../config/orm')
module.exports = {
    addCourse: (Name, Subject, StartDate, EndDate, Price, Description) => {
        return orm.selectAll(`call AddCourse('${Name}','${Subject}','${StartDate}','${EndDate}}','${Price}','${Description}')`);
    }
}