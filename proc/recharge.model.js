var orm = require('../config/orm')

module.exports = {
    rechargeMoney: (accountID,type,amount) => {
        return orm.selectAll(`call AddTransaction(${accountID},'${type}',${amount}) `)
    }
}