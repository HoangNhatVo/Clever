var orm = require('../config/orm')
module.exports = {
    findAll: (table, field, value, order) => {
        return orm.load(`select * from ${table} where ${field} = ${value} order by ${order}`)
    },
    getAll: table => {
        return orm.load(`select * from ${table}`)
    }
};