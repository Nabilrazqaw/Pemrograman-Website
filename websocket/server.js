const  webSocket = require('ws');
const wss = new webSocket.Server ({ port:3000 });

wss.on('connection', (ws) => {
    console.log('Client Connected');

    // kirim pesan ke klien setiap 3 dtik
    setInterval(() => {
        ws.send(JSON.stringify({ message: 'data dari server',
            timestam: new Date() }));
        }, 3000);

        // terima psan dari klien
        ws.on('message', (message) => {
            console.log('pesan dari client: ${message} ');
        });

        ws.on('close', () => {
            console.log('client disconected');
            });
        });

console.log('webSocket server berjalan lancar di ws://localhost:3000')