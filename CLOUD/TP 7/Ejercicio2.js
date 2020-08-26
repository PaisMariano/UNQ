var rp = require('request-promise');
const fs = require('fs');
const writeFile = require('util').promisify(fs.writeFile);

function getAvatar(id){
    rp.get(requestObject('https://reqres.in/api/users/' + id, true))
        .then(user => {
            rp.get(requestObject(user.data.avatar), false).then(img => {
                writeFile(id + '-avatar.jpg', img);
            });
        })
        .catch(err => console.log('hubo un error'));
}

function requestObject(url, isJson){
    return isJson? {uri: url, json: isJson} : {uri: url, encoding: null }
}

getAvatar(2);