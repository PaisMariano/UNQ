#include "test_tree.h"

// PROPOSITO: DEVUELVE LA CANTIDAD DE NODOS
int sizeT(GenTree t) {
    int r = 1;
    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++) {
        r += sizeT(getAt(ts, i));
    }
    return r;
}

// PROPOSITO: INDICA SI EL ELEMENTO APARECE EN EL ARBOL
bool containsT(string x, GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: INDICA LA CANTIDAD DE VECES QUE APARECE EL ELEMENTO
int occurrencesT(string x, GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LA CANTIDAD DE RAMAS
int countLeaves(GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LA ALTURA DEL ARBOL
int heightT(GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS DEL ARBOL EN UNA LISTA
// PISTA: HACER UNA SUBTAREA QUE RECIBA UNA LISTA POR PARAMETRO
// PARA PODER MODIFICARLA
List toList(GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS QUE ESTAN EN LAS HOJAS
List leaves(GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: AGREGA TODODS LOS ARBOLES DE LA LISTA
// COMO HIJOS DE "t"
void addChildren(ArrayList ts, GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS DEL NIVEL "n"
List levelN(int n, GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE EL STRING CON MAYOR LONGITUD
string stringWithMaxSize(GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: DADO UN ARRAY CON NUMEROS QUE INDICAN UN CAMINO POR EL ARBOL
// DEVUELVE LOS ELEMENTOS QUE SE ENCUENTRAN EN DICHO CAMINO
List elemsInPath(GenTree t, int path[], int pathSize) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE EL ARBOL CON MAYOR ALTURA
// PRECONDICION: LA LISTA NO ESTA VACIA
GenTree maxHeight(ArrayList ts) {
    /// COMPLETAR
}

// PROPOSITO: DEVUELVE LA CONCATENACION DE LOS ELEMENTOS DE LOS ARBOLES DE LA LISTA
List concatToList(ArrayList ts) {
    /// COMPLETAR
}

// PROPOSITO: INDICA SI TODOS LOS ELEMENTOS DE LA LISTA ESTAN EN EL ARBOL
bool containsAll(List elems, GenTree t) {
    /// COMPLETAR
}

// PROPOSITO: CONCATENA TODOS LOS STRINGS DEL ARBOL
string concatAll(GenTree t) {
    /// COMPLETAR
}

void testTree() {
    // ACA VAN LOS TEST DE LAS FUNCIONES IMPLEMENTADAS

    GenTree t = leaf("");
    for(int i = 0; i < 10; i++) {
        GenTree t2 = leaf("a");
        for(int j = 0; j < 10; j++) {
            addChild(t2, leaf("b"));
        }
        addChild(t, t2);
    }

    cout << "sum: " << sizeT(t) << endl;
    cout << "contains b: " << (containsT("b", t) ? "true" : "false") << endl;
    cout << "occurrences b: " << occurrencesT("b", t) << endl;
    cout << "leaves: " << countLeaves(t) << endl;
    cout << "height: " << heightT(t) << endl;
}
