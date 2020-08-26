const {
    cocinarCarneLadoA,
    cocinarCarneLadoB,
    tostarPan,
    obtenerCarne,
    obtenerPan,
    agregarMayonesaACarne,
} = require('./promesas');

/*
    Se desea modelar el proceso de preparación de una hamburguesa en una casa de comidas rápidas.

    Los pasos para preparar la hamburguesa son:
        a. Tostar el pan de arriba.
        b. Tostar el pan de Abajo.
        c. Cocinar la carne de un lado.
        d. Cocinar la carne del otro lado. (Depende de c)
        e. Armar la hamburguesa. (Depende de a, b y d)

    Depende significa, en este contexto, que una tarea sólo puede ser realizada cuando su predecesor ha finalizado exitosamente.

    A su vez, se necesitan obtener los panes y la carne para armar la hamburguesa.

    Además, se disponen de 5 tipos de maquinas que trabajan de manera independiente para:
      - obtener pan,
      - obtener carne
      - tostar pan
      - cocinar carne de un lado y
      - cocinar carne de otro lado.

    Estas maquinas se pueden accionar utilizando las funciones:
        obtenerCarne
            => retorna una promesa que se resuelve con el string "Carne cruda"
        cocinarCarneLadoA
            => espera "Carne cruda" como parametro
            => retorna una promesa que se resuelve con el string "Carne semicocida"
        cocinarCarneLadoB
            => espera "Carne cruda" como parametro
            => retorna una promesa que se resuelve con el string"Carne semicocida"
        obtenerPan
            => retorna una promesa que se resuelve con el string "Pan"
        tostarPan
            => espera el string "Pan" como parametro
            => retorna una promesa que se resuelve con el string "Pan tostado"

    La hamburguesa final armada deberá representarse como un array de la forma:
       ["Pan tostado", "Carne cocida", "Pan tostado"]
*/


class Restaurante {

    carneCocida() {
        // Retorna una promesa de una carne cocida
        return obtenerCarne()
        .then(
            carneCruda => cocinarCarneLadoA(carneCruda)
        ).then(
            carneSemicocida => cocinarCarneLadoB(carneSemicocida)
        );
    }

    panTostado() {
        // Retorna una promesa de un pan tostado
        return obtenerPan().then(
            pan => tostarPan(pan)
        );
    }

    prepararHamburguesa() {
        // Retorna una promesa de una Hamburguesa
        console.log("Por favor espere mientras su hamburguesa es preparada ...");
        return Promise.all(
            [this.panTostado(),
             this.carneCocida().then(
                carneCocida => agregarMayonesaACarne(carneCocida)
            ),
             this.panTostado()]
        )
    }
}

// Cliente del restaurante pidiendo la hamburguesa
const restaurante = new Restaurante();
restaurante.prepararHamburguesa()
    .then((hamburguesa) => {
        console.log("Gracias! esta es mi hamburguesa: ", hamburguesa);
    }).catch((err) => console.log("La hamburguesa no pudo ser hecha:", err));
