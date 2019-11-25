var ListSubject = require('../proc/index.model')

module.exports = (req, res ,next) => {
    res.locals.ListSub;
    ListSubject.allSubject().then(sub => {
        res.locals.ListSub= sub
        next()
    })
    .catch(err => {
        console.log(err)
    })
}