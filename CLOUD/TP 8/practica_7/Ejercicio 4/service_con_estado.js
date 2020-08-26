const express = require('express'); // Express web server framework
const bodyParser = require('body-parser');
const fs = require('fs');

const DATA_FILE = 'app_data/data.json';
const PORT = 5000 ;

const app = express();

app.use(bodyParser.json());
app.get('/api/ping', (req, res) => {
  console.log('ping arrived!');
  fs.readFile(DATA_FILE, (err, data) => {
    if (err) { // El archivo no existe
      data = { count: 0 };
    } else {
      data = JSON.parse(data);
    }

    data.count = data.count + 1;
    fs.writeFile(DATA_FILE, JSON.stringify(data, null, 2), (err) => {
      console.log('Cantidad de pings: ' + data.count);
      res.json({message: 'pong'});
    });
  });
}).get('/api/echo', (req, res) => {
  var message = req.query.message || req.body.message || 'no message provided'
  console.log('echoing ' + message);
  res.json({message: message});
});

// manage 404 not found
app.use((req, res) => {
  res.status(404);
  res.json({status: 404, errorCode: 'RESOURCE_NOT_FOUND'});
});

app.listen(PORT, () => {console.log(`Listening on ${PORT}`);});