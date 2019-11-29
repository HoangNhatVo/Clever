module.exports = (req, res, next) => {
    if(req.user){
        if(req.user.account_role == 'admin'){
            next();
        }
        else if(req.user.account_role == 'teacher'){
            res.redirect('/admin');
        }
        else {
            res.redirect('/');
        }
    }
  }