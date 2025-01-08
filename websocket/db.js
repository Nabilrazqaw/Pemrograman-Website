const mysql = require('mysql');

// konfigurasi koneksi mysql
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'websocket_db'
});

// koneksi ke databse
db.connect((err) => {
    if (err) {
        console.error('error koneksi mysql:', err);
    } else {
        console.log('koneksi mysql berhasil');
    }
});

module.exports = db;