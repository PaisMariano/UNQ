const readline = require('readline');

class Person {
    constructor(_name, _number, _kitchen){
        this._name    = _name;
        this._ticket  = _number;
        this._kitchen = _kitchen;
    }
    
    handleWaiting(seconds){
        if (!this.isMyOrderReady()){
            console.log("Soy el cliente", this._ticket, "y exijo que me atiendan!");
            this.wait(seconds);
        }else{
            console.log('Gracias por tu visita cliente', this._ticket);
            this._kitchen.removeClient(this);
        }
    }
    isMyOrderReady(){
        return this._ticket === this._kitchen.turn;
    }
    
    wait(seconds){
        setTimeout(this.handleWaiting.bind(this, seconds), seconds * 2000);
    }
}

class Kitchen {
    constructor(_rl){
        this._turn    = 0;
        this._clients = [];
        this._rl      = _rl;
    }
    get turn(){return this._turn;}
    set turn(aTurn){this._turn = aTurn;}
    get clients(){return this._clients;}

    removeClient(aClient){
        this._clients = this._clients.filter(client => client !== aClient)
        this.finishedOrder();
    }
    finishedOrder(){
        if (this.clients.length === 0){
            this._rl.close();
            console.log("------------------  CERRADO  --------------------")
        }
    }
}

function createClients(ammount, kitchen){
    let client;
    for (i = 1; i <= ammount; i++){
        client = new Person('Cliente '.concat(i), i, kitchen);
        kitchen.clients.push(client);
        client.wait(randomInt(3, 5));        
    }
}

function randomInt(min, max) {
	return min + Math.floor((max - min) * Math.random());
}

function main(){        
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    let kitchen = new Kitchen(rl);
    
    var name = readline();

    createClients(5, kitchen);

    rl.on('line', (input) => {
        kitchen.turn = parseInt(input)
    });

}

main();