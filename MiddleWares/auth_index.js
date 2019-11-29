module.exports = (req, res, next) => {
    if(req.user){
        if(req.user.account_role == 'student'){
            res.redirect('/');
        }
        else {
            next();
        }
    }
  }