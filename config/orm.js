const connection = require("./connection");
const orm = {
    selectAll: sql =>{
        return new Promise((resolve,reject)=>{

            connection.query(sql,(err,results,fields)=>{
                if(err)
                reject.err;
                else{
                    resolve(results[0]);
                }
                
            });
        });
    },

    load: sql => {
        return new Promise((resolve, reject) => {

          connection.query(sql, (error, results, fields) => {
            if (error) {
              reject(error);
            } else {
              resolve(results);
            }

          });
        });
      },

    add: (tableName, entity) => {
        return new Promise((resolve, reject) => {
          var sql = `insert into ${tableName} set ?`;

          connection.query(sql, entity, (error, value) => {
            if (error) {
              reject(error);
            } else {
              resolve(value.insertId);
            }

          });
        });
      },
  
      update: (tableName, idField, entity) => {
        return new Promise((resolve, reject) => {
          var id = entity[idField];
          delete entity[idField];
    
          var sql = `update ${tableName} set ? where ${idField} = ?`;

          connection.query(sql, [entity, id], (error, value) => {
            if (error) {
              reject(error);
            } else {
              resolve(value.changedRows);
            }

          });
        });
      },
  
      delete: (tableName, idField, id) => {
        return new Promise((resolve, reject) => {
          var sql = `delete from ${tableName} where ${idField} = ?`;

          connection.query(sql, id, (error, value) => {
            if (error) {
              reject(error);
            } else {
              resolve(value.affectedRows);
            }

          });
        });
      },
};
module.exports = orm;