var orm = require('../config/orm')
module.exports = {
    callProc: proc => {
        return orm.selectAll(`call ${proc}`)
    },
    executeQuery: sql => {
        return orm.load(sql);
    },
    findAll: table => {
        return orm.load(`select * from ${table}`);
    },
    createOne: (table, entity) => {
        return orm.add(table, entity);
    },
    getOne: (table, field, value) => {
        return orm.selectAll(`select * from ${table} where ${field} = '${value}'`)
    },
    getAll: (table, field, value) => {
        return orm.load(`select * from ${table} where ${field} = '${value}'`)
    },
    updateOne: (table, id, entity) => {
        return orm.update(table, id, entity)
    },
    deleteAll: (table, field, value) => {
        return orm.delete(table, field, value)
    }
};