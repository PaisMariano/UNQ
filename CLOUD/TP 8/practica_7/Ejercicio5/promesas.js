function randInt(min, max) {
    return Math.floor(Math.random() * (max - min) ) + min;
}

const NO_RESOURCE = "NO_RESOURCE";
const RANDOM = "RANDOM";
let lastActionId = 0;

class Action {

    constructor(description, output, expectedResource = NO_RESOURCE) {
        lastActionId++;
        this.id = lastActionId;
        this.description = description;
        this.output = output;
        this.expectedResource = expectedResource;
    }

    doIt(resource = NO_RESOURCE, time = RANDOM) {
        if (this.expectedResource !== resource) {
            let resourceStr = (resource === NO_RESOURCE)? "ninguno" : `"${resource}"`;
            return Promise.reject(
                `[${this.id}]"${this.description}" esperaba el recurso: "${this.expectedResource}" pero ${resourceStr} fue provisto`
            );
        }

        return new Promise(
            (resolve, reject) => {
                console.log(`[${this.id}][INICIANDO]`, this.description);
                this.startTime = new Date().getTime();
                setTimeout( () => {
                    let duration = new Date().getTime() - this.startTime;
                    console.log(`[${this.id}][TERMINADO] [${duration}ms] ${this.description}`);
                    resolve(this.output);
                }, (time == RANDOM) ? randInt(500, 2500): time
            )
        });
    }
}


module.exports = {
    // Bebida
    obtenerVaso: function() {
        return new Action("Obtener vaso", "Vaso").doIt();
    },

    prepararBebida: function(input) {
        return new Action("Preparar bebida", "Bebida", "Vaso").doIt(input);
    },

    // Papas
    obtenerPapas: function () {
        return new Action("Obtener Papas", "Papas").doIt();
    },

    freirPapas: function(input) {
        return new Action("Freir Papas", "Papas fritas", "Papas").doIt(input);
    },
    empaquetarPapas: function(input) {
        return new Action("Empaquetar Papas", "Papas fritas empaquetadas", "Papas fritas").doIt(input);
    },
    salarPapas: function(input) {
        return new Action("Salar Papas", "Papas fritas empaquetadas con sal", "Papas fritas empaquetadas").doIt(input);
    },

    // Hamburguesa
    obtenerCarne: function () {
        return new Action("Obtener Carne", "Carne Cruda").doIt();
    },

    obtenerPan: function () {
        return new Action("Obtener Pan", "Pan").doIt(NO_RESOURCE);
    },

    tostarPan: function(input) {
        return new Action("Tostar Pan", "Pan tostado", "Pan").doIt(input);
    },

    cocinarCarneLadoA: function(input) {
        return new Action("Cocinar carne del Lado A", "Carne semicocida", "Carne Cruda").doIt(input);
    },

    cocinarCarneLadoB: function(input) {
        return new Action("Cocinar carne del lado B", "Carne cocida", "Carne semicocida").doIt(input);
    },

    agregarMayonesaACarne: function(input){
	return new Action("Agregar mayonesa a carne cocida", "Carne cocida con mayonesa", "Carne cocida").doIt(input);
    },
}
