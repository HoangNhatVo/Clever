var orm = require('../config/orm')
module.exports = {
    addAccount: (Role, Email, Phone, Username, Password, FirstName, LastName, Address, Birthdate) => {
        return orm.selectAll(`call AddAccount('${Role}','${Email}','${Phone}','${Username}','${Password}','${FirstName}','${LastName}','${Address}','${Birthdate}')`);
    },
    getAccountByUsername: (Username) => {
        return orm.selectAll(`call GetAccountByUsername('${Username}')`);
    },
    getAccountByEmail: (Email) => {
        return orm.selectAll(`call GetAccountByEmail('${Email}')`);
    },
    getAccountByPhone: (Phone) => {
        return orm.selectAll(`call GetAccountByPhone('${Phone}')`);
    },
    getAccountDetails:(ID)=>{
        return orm.selectAll(`call GetAccountDetails(${ID})`);
<<<<<<< Updated upstream
=======
    },
    getAccountByID:(ID)=>{
        return orm.selectAll(`call GetAccountByID(${ID})`);
    },
    updatePasswordAccountByID:(ID, newPass)=>{
        return orm.selectAll(`call UpdatePasswordAccountByID(${ID},'${newPass}')`);
    },
    getListTeacher:()=>{
        return orm.selectAll(`call GetAccountByRole('teacher')`);
>>>>>>> Stashed changes
    }
}