const util = require('util'); const fs = require('fs'); const os = require('os');
const writeFilePromise = util.promisify(fs.writeFile);
const readFilePromise = util.promisify(fs.readFile);


const dataObj = {username: os.userInfo().username, hostname: os.hostname()};
const promise1 = writeFilePromise('data.json', JSON.stringify(dataObj));

promise1.then(exitoCallbackEscritura).catch(falloCallbackEscritura);

function exitoCallbackEscritura(){console.log('Se grabó correctamente el archivo. \n')}

function falloCallbackEscritura(error){console.log('Falló la escritura del archivo. Error:', error)}

function exitoCallbackLectura(data){
    let objectoParseado = JSON.parse(data);
    console.log('Se leyó correctamente el archivo con los siguientes datos:')
    console.log(objectoParseado);
}

function falloCallbackLectura(error){console.log('Falló la lectura del archivo. Error:', error)}

const promise2 = readFilePromise('data.json');

promise2.then(exitoCallbackLectura).catch(falloCallbackLectura);