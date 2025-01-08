const webSocket = require('ws');
const db = require('./db');

// koneksi ke websocket server
const ws = new webSocket('ws://localhost:3000');

ws.on('open', () => {
    console.log('terhubun ke webSocket server');
    // kirim pesan ke server
    ws.send('halo server! ini dari client');
});

// terima data dari websocket server
ws.on('message', (data) => {
    console.log ('data diterima dari server: ', data);

    // simpan ke mysql
    const jsonData = JSON.parse(data);
    const query = 'INSERT INTO logs (message, timestamp) VALUES (?,?)';
    const values = [jsonData.message, jsonData.timestamp];

    db.query(query, values, (err, result) => {
        if (err) {
            console.error('gagal menyimpan data ke mysql:', err);
        } else {
            console.log('data berhasil disimpan ke mysql, ID: ', result.insertId);
        }
    });
});

// handle error
ws.on('error', (err) => {
    console.error('gagal terima data dari mysql:', err);
});

ws.on('close', () => {
    console.log('terhubun ke webSocket di tutip');
});
