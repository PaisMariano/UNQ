const {
    cocinarCarneLadoA,
    cocinarCarneLadoB,
    obtenerPan,
    obtenerPapas,
    obtenerCarne,
    tostarPan,
    freirPapas,
    empaquetarPapas,
    salarPapas,
    obtenerVaso,
    prepararBebida,
} = require('./promesas');

/*
    Continuando con el ejemplo anterior, ahora se desea modelar el armado de un pedido completo,
    el cual esta compuesto por: bebida, papas fritas y una hamburguesa.

    Los pasos para armar el pedido son:
        1. Preparar las papas fritas
        2. Preparar la bebida.
        3. Preparar la hamburguesa (ya lo tiene resuelto por el ejemplo provisto).
        4. Poner todo en la bandeja. (1, 2 y 3 deben estar terminados)

    Preparar las papas implica
      a. Obtener las papas
      b. Freir las papas (depende de b)
      c. Empaquetarlas (depende de c)
      d. salarlas (depende de d)

    Preparar la bebida implica:
      a. Obtener un vaso
      b. Servir la bebida en el vaso.


    Además, se disponen de 3 empleados: uno que prepara las papas, otro que prepara hambuerguesas y otro
    que prepara bebidas. Cada empleado trabaja de manera independiente.

    Usted dispone de las siguientes funciones:
        obtenerVaso
            => retorna una promesa que se resolverá con el string "Vaso"
        prepararBebida
            => espera el string "Vaso" como parametro
            => retorna una promesa que se resolverá con el string "Vaso servido"
        obtenerPapas
            => retorna una promesa que se resolverá con el string "Papas"
        freirPapas
            => espera el string "Papas" como parametro
            => retorna una promesa que se resolverá con el string "Papas fritas"
        empaquetarPapas
            => espera el string "Papas fritas" como parametro
            => retorna una promesa que se resolverá con el string "Papas fritas empaquetadas"
        salarPapas
            => espera el string "Papas fritas empaquetadas" comop parametro
            => retorna una promesa que se resolverá con el string "Papas fritas empaquetadas con con sal"

    El pedido debera ser un objeto javascript de la forma:
    {
        papas: 'Papas fritas empaquetadas con sal',
        hamburguesa: ["Pan tostado", "Carne cocida", "Pan tostado"],
        bebida: 'Vaso servido',
    }
*/

class Empleado {

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
        return Promise.all(
            [this.panTostado(), this.carneCocida(), this.panTostado()]
        );
    }

    prepararPapas(salar) {
        // Retorna una promesa de papas fritas
        return obtenerPapas()
        .then(
            papas => freirPapas(papas)
        ).then(
            papasFritas => empaquetarPapas(papasFritas)
        ).then(papasEmp => { 
            if (salar) {
                papasEmp = salarPapas(papasEmp)
            }
            return papasEmp
        })  
    }

    prepararBebida() {
        // Retorna una promesa de un vaso bebible
        return obtenerVaso()
        .then(
            bebida => prepararBebida(bebida).catch(
                (error) => {return "Botella de agua"}
            )
        )
    }
}

class Restaurante {
    constructor() {
        this.empleados = [new Empleado(), new Empleado(), new Empleado()]
    }

    armarPedido(papasSal) {
        return Promise.all(
            [this.empleados[0].prepararPapas(papasSal),
             this.empleados[1].prepararBebida(),
             this.empleados[2].prepararHamburguesa()]
        ).then(
            pedido => ({
                papas: pedido[0],
                hamburguesa: pedido[2],
                bebida: pedido[1]
                }
            )
        );
    }
}


// Cliente del restaurante pidiendo la hamburguesa
const restaurante = new Restaurante();

// Cliente 1 solicita un Menu
let pedido = restaurante.armarPedido(false)
    .then((pedido) => {
        console.log("[CLIENTE 1]-----------");
        console.log("[CLIENTE 1] Gracias! este es mi pedido: ");
        console.log(pedido);
    }).catch((error) => {
        console.log("[CLIENTE 1] -----------");
        console.log("[CLIENTE 1] Oops, algo malo pasó con el pedido");
        console.log(error);
    });