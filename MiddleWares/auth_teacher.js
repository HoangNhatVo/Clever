module.exports = (req, res, next) => {
    if(req.user){
        if(req.user.account_role == 'teacher' || req.user.account_role == 'admin'){
            next();
        }
        else {
            res.redirect('/');
        }
    }
  }