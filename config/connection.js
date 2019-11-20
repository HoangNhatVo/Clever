const mysql = require('mysql');
let connection;

if (process.env.JAWSDB_URL) {
    connection = mysql.createConnection(process.env.JAWSDB_URL);
}
else {
    connection = mysql.createConnection({
        host: 'db4free.net',
        user: 'cleverteam',
        password: '11119999',
        database: 'cleverdbbeta'
    });
    connection.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
      });
}

module.exports = connection;
