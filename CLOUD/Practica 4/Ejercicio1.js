function main(){
    let pepe = '{"firstName":"Pepe","lastName":"Argento","age":45}';
//EJ1
console.log(pepe);

console.log("-------------------------");

let obj = JSON.parse(pepe);
console.log(obj);
obj.age = 50;
console.log(obj);
console.log("-------------------------");
console.log(JSON.stringify(obj));
console.log("-------------------------");

//EJ2
let datos = '[1, 2, 3, 4]';
let datos2 = [1, 2, 3];

console.log(typeof(datos)); //string
console.log("-------------------------");
console.log(typeof(datos2)); //object
console.log("-------------------------");
let datos3 = JSON.parse(datos); //object
console.log(typeof(datos3));
console.log("-------------------------");
let datos4 = JSON.stringify(datos2); //string
console.log(typeof(datos4));
console.log("-------------------------");
//EJ3

class User {
   constructor(name , friends = []) {
       this.name = name;
       this.friends = friends;
   }
   addFriend(aUser) {
     this.friends.push(aUser);
   }
}
 
let user1 = new User('user1');
let user2 = new User('user2');
user1.addFriend(user2);
user2.addFriend(user1);


/*
JSON.stringify(user1);
se lanzo un TypeError
TypeError: cyclic object value

porque al querer transformar a string un objeto que tiene como colaborador a un objeto que a su vez tiene como colaborador al primer objeto, se encuentra que generaria un string del mismo objeto que generó, y que seria un loop infinito, con lo cual genera la excepcion.
*/

function toJSON(aUser){
  let tempUser = aUser;
  tempUser.friends = tempUser.friends.filter(elem => {
    elem !== aUser;
  })
  return JSON.stringify(tempUser);
}

console.log(toJSON(user1));

}

main();