let express     = require('express');        // import express
let app         = express();                 // define our app using express
let router      = express.Router();
let fs          = require('fs');
let readDir     = require('util').promisify(fs.readdir);
let writeFile   = require('util').promisify(fs.writeFile);
let delFile     = require('util').promisify(fs.unlink);
let readFile    = require('util').promisify(fs.readFile);
let bodyParser  = require('body-parser');

let port = process.env.PORT || 8081;        // set our port

router.get('/', function(req, res) {
   res.json({ message: 'hooray! welcome to our api!' });  
});

router.route('/actions')
.get((req, res) => {
    const data = req.body; // JSON Parseado
    readDir(data.path).then(files => {
        res.json({ files: files });
    }).catch(err => {
        console.log('input incorrecto.');
        res.status("400");
        res.json({status: "400", errorCode: "input incorrecto."});
    })   
})
.post((req, res) => {
    const data = req.body;
    writeFile(data.path+'/'+data.filename, data.content).then(r => {
        console.log('Se grabó el archivo correctamente.');
        res.status("200");
        res.json({ message : 'Se grabó el archivo correctamente.'});
    }).catch(err => {
        console.log('No se pudo grabar el archivo.');
        res.status("400");
        res.json({ message : 'No se pudo grabar el archivo.'});
    })
})
.delete((req, res) => {
    const data = req.body;
    if (data.path === ""){
        new InvalidInputError();
    }else{
        delFile(data.path).then(() => {
            console.log('Se ha borrado el archivo.');
            res.status("200");
            res.json({ message : 'Se ha borrado el archivo.'});
        }).catch(() => {
            console.log('No se pudo borrar el archivo.');
            res.status("400");
            res.json({ message : 'No se pudo borrar el archivo.'});  
        })
    }
})
.patch((req, res) => {
    const data = req.body;
    if (data.path === ""){
        new InvalidInputError();
    }else{
        readFile(data.path, 'utf8').then(file => {
            console.log('Se ha leido el archivo.');
            res.status("200");
            res.json({ message : file});
        }).catch(() => {
            console.log('No se pudo leer el archivo.');
            res.status("400");
            res.json({ message : 'No se pudo leer el archivo.'});  
        })
    } 
});

app.use(bodyParser.json());
app.use('/api', router);
app.listen(port);
app.use(errorHandler);

console.log("Escuchando en el puerto %d...", port)

function errorHandler(err, req, res, next) {
    console.error(err); // imprimimos el error en consola
    // Chequeamos que tipo de error es y actuamos en consecuencia
    if (err instanceof InvalidInputError){
      res.status(err.status);
      res.json({status: err.status, errorCode: err.errorCode});
    } else if (err.type === 'entity.parse.failed'){
      // body-parser error para JSON invalido
      res.status(err.status);
      res.json({status: err.status, errorCode: 'INVALID_JSON'});
    } else {
      // continua con el manejador de errores por defecto
      next(err);
    }
 }

 class APIError extends Error {
    constructor(name, statusCode, errorCode, message = null) {
      super(message || name);
      this.name = name;
      this.status = statusCode;
      this.errorCode = errorCode;
    }
 }
 
 class InvalidInputError extends APIError {
    constructor() {
      super('InvalidInputError', 400, 'INVALID_INPUT_DATA');
    }  
 }
 