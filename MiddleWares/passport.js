var LocalStrategy   = require('passport-local').Strategy;
const accountModel = require('../proc/account.model');
var request = require('request');
var moment = require('moment');
const bCrypt = require('bcrypt');
const saltRounds = 10;

module.exports = function(passport) {

   passport.serializeUser(function(user, done) {
        done(null, user);
    });

    passport.deserializeUser(function(user, done) {
        done(null, user);
    });

   passport.use('local-login', new LocalStrategy({
        usernameField : 'username',
        passwordField : 'password',
        passReqToCallback : true
    },
    function(req, username, password, done) {
        accountModel.getAccountByUsername(username).then(user => {
            if(!user.length){
                console.log('abcd');
                return done(null, false, req.flash('loginMessage', 'Tài khoản không tồn tại.'));
            }           
            if(!bCrypt.compareSync(password, user[0].account_password)){
                return done(null, false, req.flash('loginMessage', 'Mật khẩu không đúng.'));
            }     
            
            console.log(username+password);
            return done(null, user[0]);

        }).catch(err =>{
            console.log(err);
            return done(null, false, req.flash('loginMessage', 'Lỗi đăng nhập.'));
        });

    }));


    passport.use('local-signup', new LocalStrategy({
        usernameField : 'username',
        passwordField : 'password',
        passReqToCallback : true 
    },
    function(req, username, password, done) {
        accountModel.getAccountByUsername(username).then(r1=>{
            if(r1.length){
                return done(null, false, req.flash('registerMessage', 'Usernam đã tồn tại.'));
            }
            else{
                accountModel.getAccountByEmail(req.body.email).then(r2=>{
                    if(r2.length){
                        return done(null, false, req.flash('registerMessage', 'Email đã tồn tại.'));
                    }
                    else{
                        accountModel.getAccountByPhone(req.body.phone).then(r3=>{
                            if(r3.length){
                                return done(null, false, req.flash('registerMessage', 'SĐT đã tồn tại.'));
                            }
                            else{
                                var account = {
                                    Role: "student",
                                    Email: req.body.email,
                                    Phone: req.body.phone,
                                    Usernam: username,
                                    Password: bCrypt.hashSync(password, bCrypt.genSaltSync(saltRounds)),
                                    FirstName: req.body.firstname,
                                    LastName: req.body.lastname,
                                    Address: req.body.address,
                                    Birthdate: moment(req.body.birthdate,'DD/MM/YYYY').format('YYYY-MM-DD')
                                }
                                console.log(account);
                                accountModel.addAccount(account.Role, account.Email, account.Phone, account.Usernam, account.Password,
                                    account.FirstName, account.LastName, account.Address, account.Birthdate).then(r=>{
                                        return done(null, true, req.flash('registerMessage', 'Đăng ký thành công'));
                                    }).catch(err=>{
                                        console.log(err);
                                        return done(null, false, req.flash('registerMessage', 'Lỗi đăng kí.'));
                                    })
                            }
                        }).catch(err=>{
                            console.log(err);
                            return done(null, false, req.flash('registerMessage', 'Lỗi đăng kí.'));
                        })
                    }
                }).catch(err=>{
                    console.log(err);
                    return done(null, false, req.flash('registerMessage', 'Lỗi đăng kí.'));
                })
            }
        }).catch(err=>{
            console.log(err);
            return done(null, false, req.flash('registerMessage', 'Lỗi đăng kí.'));
            })
        }
    ));
};