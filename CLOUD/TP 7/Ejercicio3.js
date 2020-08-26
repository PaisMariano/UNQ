var rp = require('request-promise');
const fs = require('fs');
const writeFile = require('util').promisify(fs.writeFile);
const BASE_URL = 'http://api.musixmatch.com/ws/1.1/';

function getAllAlbumsByArtistId(id){
    let options = {
        uri: BASE_URL + 'artist.albums.get',
        qs: {
            apikey: 'cf4c761b3b9884733988f4f0a0bfe2ad',
            artist_id: id,
        },
        json: true // Automatically parses the JSON string in the response
        };
    
        return rp.get(
        options
        ).then((response) => {
        let header = response.message.header;
        if (header.status_code !== 200){
            throw new Error('status code != 200');
        }
        return response.message.body.album_list;
        });

}

function getAllTracksByAlbumId(id){
    let options = {
        uri: BASE_URL + 'album.tracks.get',
        qs: {
            apikey: 'cf4c761b3b9884733988f4f0a0bfe2ad',
            album_id: id,
        },
        json: true // Automatically parses the JSON string in the response
        };
    
        return rp.get(
        options
        ).then((response) => {
        var header = response.message.header;
        if (header.status_code !== 200){
            throw new Error('status code != 200');
        }
        
        return response.message.body.track_list;
        });
}

function getAllTracksByArtist(id){

    let promisedAlbums = getAllAlbumsByArtistId(id);
    let promisedTracks = promisedAlbums.map(album => (
        getAllTracksByAlbumId(album.album.album_id)
    ))
    
    promisedTracks.then(tracks => (
        Promise.all(tracks))).then(realTracks => (
            console.log(JSON.stringify(realTracks)))).then(() => console.log("termine"));

}

function requestObject(url, isJson){
    return isJson? {uri: url, json: isJson} : {uri: url, encoding: null }
}

function getAllAlbumsByArtist(id){

    let promisedAlbums = getAllAlbumsByArtistId(id);
    promisedAlbums.map(album => {
        console.log(album.album.album_name);

        //LA API RESUME EL JSON Y NO TRAE LOS DATOS DEL ALBUM...
        // return rp.get(
        //     requestObject(album.album.album_coverart_100x100, false)
        // ).then(img => {
        //     writeFile(album.album.album_name + '.jpg', img);
        // }).catch(error => console.log("Ocurrio un error"))
    })
}

getAllAlbumsByArtist(1039);