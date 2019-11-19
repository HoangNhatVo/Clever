var orm = require('../config/orm')
module.exports = {
    findAll: table => {
        return orm.load(`select * from ${table}`);
    },
    // allCourse: page => {
    //     return orm.selectAll(`call GetActiveCourseList(${page})`);
    // },
    // addCourse: (name, subject, start_date, end_date, price, description) => {
    //     return orm.selectAll(`call AddCourse(${name},${subject},${start_date},${end_date},${price},${description})`);
    // }
    createOne: (table, entity) => {
        return orm.add(table, entity);
    },
    getOne: (table, field, value) => {
        return orm.selectAll(`select * from ${table} where ${field} = ${value}`)
    },
    updateOne: (table, id, entity) => {
        return orm.update(table, id, entity)
    },
    deleteOne: (table, idField, id) => {
        return orm.delete(table, idField, id)
    }
};