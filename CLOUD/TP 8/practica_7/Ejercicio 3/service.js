const express = require('express'); // Express web server framework
const bodyParser = require('body-parser');

const PORT = 5000 ;

const app = express();

app.use(bodyParser.json());
app.get('/api/ping', (req, res) => {
  console.log('ping arrived!');
  res.json({message: 'pong'});
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