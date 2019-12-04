module.exports = (req, res, next) => {
  if (req.user) {
    res.locals.isAuthenticated = true;
    res.locals.user = req.user;
    if(req.user.account_role == 'admin'){
      res.locals.isAdministrator = true;
    }
    if(req.user.account_role == 'teacher'){
      res.locals.isTeacher = true;
    }
    if(req.user.account_role != 'student'){
      res.locals.isAdmin = true;
    }
    if(req.user.account_role == 'student'){
      res.locals.isStudent = true;
    }
  }
  next();
}
