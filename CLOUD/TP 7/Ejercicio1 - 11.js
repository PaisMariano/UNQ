let express    = require('express');        // import express
let app        = express();                 // define our app using express
let router = express.Router();  

let port = process.env.PORT || 8080;        // set our port

router.get('/', function(req, res) {
   res.json({ message: 'hooray! welcome to our api!' });  
});

app.use('/api', router);
router.route('/artists/:artistId').get(function (req, res) {
  const artistId = req.params.artistId
  const artista = unqfy.getArtistById(artistId)
  res.send(JSON.stringify(artista))
});
