#include "test_tree.h"
#include <string.h>


// PROPOSITO: DEVUELVE LA CANTIDAD DE NODOS
///EFICIENCIA: o(n): Donde n son todos los nodos del arbol.
int sizeT(GenTree t) {
    int r = 1;
    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++) {
        r += sizeT(getAt(ts, i));
    }
    return r;
}

// PROPOSITO: INDICA SI EL ELEMENTO APARECE EN EL ARBOL
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
///tomando en cuenta el peor caso que es cuando no lo contiene.
bool containsT(string x, GenTree t)
{
    bool cond = (x == value(t));

        ArrayList ts = children(t);
        for(int i = 0; i < length(ts) && (not cond); i++) {
            cond = containsT(x, getAt(ts, i));

    }
    return cond;
}

// PROPOSITO: INDICA LA CANTIDAD DE VECES QUE APARECE EL ELEMENTO
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
int occurrencesT(string x, GenTree t) {
    int r = 0;

    if (x == value(t))
        r++;

    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++) {
        r += occurrencesT(x, getAt(ts, i));
    }
    return r;
}

// PROPOSITO: DEVUELVE LA CANTIDAD DE HOJAS
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
int countLeaves(GenTree t) {
    int r = 0;
    ArrayList ts = children(t);

    if (length(ts) == 0){
        r = 1;
    }

    for(int i = 0; i < length(ts); i++) {
        r +=countLeaves(getAt(ts, i));
    }
    return r;
}

// PROPOSITO: DEVUELVE LA ALTURA DEL ARBOL
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
int heightT(GenTree t){
    int alt = 1;
    ArrayList ts = children(t);

    for(int i = 0; i < length(ts); i++){
        alt = max(alt, heightT(getAt(ts, i)) + 1);
    }

    return alt;
}
// PROPOSITO: DADA UNA LISTA XS AGREGA EL VALUE(t) DE TODOS LOS NODOS.
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
void toList(List& xs , GenTree t){  //recorre la lista y agrega a xs todos sus valores.
    snoc(xs, value(t));
    ArrayList ts = children(t);
    for (int i = 0; i < length(ts); i++){
        toList(xs, getAt(ts, i));
    }
}
//PROPOSITO: DEVUELVE LOS ELEMENTOS DEL ARBOL EN UNA LISTA.
//PISTA: HACER UNA SUBTAREA QUE RECIBA UNA LISTA POR PARAMETRO
//PARA PODER MODIFICARLA

List toList(GenTree t) {
    List xs = nil();
    toList(xs, t);
    return xs;
}
// PROPOSITO: DADA UNA LISTA XS AGREGA EL VALUE(t) DE LOS NODOS QUE NO TIENEN HIJOS.
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
void leaves(List& xs, GenTree t){
    ArrayList ts = children(t);
    if (length(ts) == 0){   //solo agrega lo que no tiene hijos.
        snoc(xs, value(t));
    }

    for(int i = 0; i < length(ts); i++){
        leaves(xs, getAt(ts, i)); //va llenando xs con la recursion.
    }
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS QUE ESTAN EN LAS HOJAS
List leaves(GenTree t) {
    List xs  = nil();
    leaves(xs, t);
    return xs;
}

// PROPOSITO: AGREGA TODOS LOS ARBOLES DE LA LISTA
// COMO HIJOS DE "t"
///EFICIENCIA: O(n): Donde n son los elementos de ts.
void addChildren(ArrayList ts, GenTree t) {
    for (int i=0;i < length(ts);i++){
        addChild(t, getAt(ts, i)); //agrega uno a uno los arboles de ts.
    }
}
//PROPOSITO: DEVUELVE UNA LISTA CON LOS VALUE(t) DEL NIVEL N.
//PRECONDICION: J DEBE SER MENOR O IGUAL A TOPE, Y MAYOR O IGUAL A 0.
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
///tomando en cuenta el peor caso, que es cuando dan por parametro el ultimo nivel.
void levelN(List& xs, GenTree t, int j, int tope){
    ArrayList ts = children(t);

    if (tope == j){   //solo agrega cuando llega al nivel n.
        snoc(xs, value(t));
    }
    for(int i = 0; i < length(ts); i++){
        levelN(xs, getAt(ts, i), j+1, tope);
    }
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS DEL NIVEL "n"
List levelN(int n, GenTree t) {
    List xs  = nil();
    levelN(xs, t, 0, n);  //va llenando xs con la recursion. Restando uno a N para llegar a 0.
    return xs;
}
// PROPOSITO: COMPARA DOS STRING Y DEVUELVE EL DE MAYOR SIZE()
///EFICIENCIA: O(size)+O(size): Cuesta lo que cueste size las dos veces que lo utiliza.
string maxS(string s1, string s2){
    string st;
    if (s1.size() >= s2.size()){
        st = s1;
    }else{
        st = s2;
    }
    return st;
}

// PROPOSITO: DEVUELVE EL STRING CON MAYOR LONGITUD
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
string stringWithMaxSize(GenTree t) {
    string st = value(t); //Para los casos que no tiene children.
    ArrayList ts = children(t);

    for(int i = 0; i < length(ts); i++)
        st = maxS(st, stringWithMaxSize(getAt(ts, i))); //maxS del actual con la recursion

    return st;
}

// PROPOSITO: DADO UN ARRAY CON NUMEROS QUE INDICAN UN CAMINO POR EL ARBOL
// DEVUELVE LOS ELEMENTOS QUE SE ENCUENTRAN EN DICHO CAMINO
// PRECONDICION: EXISTEN NODOS EN EL CAMINO INDICADO POR PATH,
//Y PATHSIZE EQUIVALE A EL LARGO DE PATH. ERGO PATH DEBE SER MAYOR IGUAL QUE 0.
///EFICIENCIA: O(n): Donde n es el tamaño de pathSize.
void elemsInPath(GenTree t, int path[], int pathSize, int j, List& xs){

    if (j < pathSize){
        ArrayList ts = children(t);
        elemsInPath(getAt(ts, path[j]), path, pathSize, j+1, xs);
    }
    snoc(xs, value(t));
}

List elemsInPath(GenTree t, int path[], int pathSize){

    List xs = nil();
    elemsInPath(t, path, pathSize, 0, xs);
    return xs;
}
//PROPOSITO: TOMA DOS ARBOLES Y LOS COMPARA USANDO heightT().
///EFICIENCIA: O(n): (n+m) Porque cuesta lo que cuesta heightT.
GenTree maxH(GenTree t1, GenTree t2){
    if (heightT(t1) > heightT(t2)){
        return t1;
    }else{
        return t2;
    }
}

// PROPOSITO: DEVUELVE EL ARBOL CON MAYOR ALTURA
// PRECONDICION: LA LISTA NO ESTA VACIA
///EFICIENCIA: O(n*m): Donde n es el tamaño de ts y m es la eficiencia de maxH.
GenTree maxHeight(ArrayList ts) {
    GenTree maximo = getAt(ts, 0);
    for (int i=1; i<length(ts);i++){
        maximo = maxH(maximo, getAt(ts, i));
    }
    return maximo;
}

// PROPOSITO: DEVUELVE LA CONCATENACION DE LOS ELEMENTOS DE LOS ARBOLES DE LA LISTA
///EFICIENCIA: O(n*m): Donde n son todos los elementos de ts y m es la eficiencia de toList.
List concatToList(ArrayList ts) {
    List listArbol = nil();

    for (int i=0; i<length(ts); i++){
        toList(listArbol, getAt(ts, i));
    }
    return listArbol;
}

// PROPOSITO: INDICA SI TODOS LOS ELEMENTOS DE LA LISTA ESTAN EN EL ARBOL
///EFICIENCIA: O(n*m): Donde n son todos los elementos de elems y m es la eficiencia de containsT.
bool containsAll(List elems, GenTree t) {
    ListIterator it = initIt(elems);
    bool cond = true;

    while(not finished(it) && cond){
        cond = containsT(getCurrent(it), t);
        next(it);
    }
    return cond;
}

// PROPOSITO: CONCATENA TODOS LOS STRINGS DEL ARBOL
///EFICIENCIA: O(n): Donde n son todos los nodos del arbol.
string concatAll(GenTree t) {
    string r = value(t);
    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++) {
        r = r + concatAll(getAt(ts, i));
    }
    return r;
}

void testTree() {
    //Genero 3 GenTree para los tests de ElemsInPath (genero hijos de "")
    //Para tener un arbol con huecos.

    GenTree x = leaf("x");
    GenTree y = leaf("y");
    GenTree z = leaf("z");
    addChild(y, z);
    addChild(x, y);

    GenTree t = leaf("");
    for(int i = 0; i < 10; i++) {
        GenTree t2 = leaf("a");
        for(int j = 0; j < 10; j++) {
            addChild(t2, leaf("b"));
        }
        addChild(t, t2);
        if (i == 5){ //Agrego cuando estoy en la posicion 5 el arbol x.
            addChild(t, x);
        }

    }
    ///TESTING:

    cout << "sum: " << sizeT(t) << endl;
    cout << "contains b: " << (containsT("b", t) ? "true" : "false") << endl;
    cout << "occurrences b: " << occurrencesT("b", t) << endl;
    cout << "leaves: " << countLeaves(t) << endl;
    cout << "height: " << heightT(t) << endl;
    cout << "" << endl;
    cout << "addChild(t, leaf('hola')): " << endl;
    addChild(t, leaf("hola"));
    printList(toList(t));

    cout << "" << endl;
    cout << "printList(leaves(t)): " << endl;
    printList(leaves(t));
    cout << "" << endl;

    ArrayList ts = crearArrayList();
    cout << "GenTree t1 = leaf('hijo1');" << endl;
    cout << "GenTree t2 = leaf('hijo2');" << endl;
    GenTree t1 = leaf("hijo1");
    GenTree t2 = leaf("hijo2");
    add(ts, t1);
    add(ts, t2);
    cout << "addChildren(ts, t): " << endl;
    addChildren(ts, t);
    printList(toList(t));

    cout << "" << endl;
    cout << "level 0:" << endl;
    printList(levelN(0, t));
    cout << "" << endl;
    cout << "level 1:" << endl;
    printList(levelN(1, t));
    cout << "" << endl;
    cout << "level 2:" << endl;
    printList(levelN(2, t));

    cout << "" << endl;
    cout << "stringWithMaxSize(t): " << stringWithMaxSize(t) << endl;
    cout << "" << endl;
    int path[3];
    path[0] = 6;
    path[1] = 0;
    path[2] = 0;
    cout << "elemsInPath:" << endl;
    printList(elemsInPath(t, path, 3));
    cout << "" << endl;

    GenTree maxH = maxHeight(ts);
    cout << "maxHeight: " << endl;
    printList(toList(maxH));

    cout << "" << endl;
    cout << "concatToList(t): " << endl;
    printList(concatToList(ts));

    List cAll = nil();
    snoc(cAll, "hijo1");
    snoc(cAll, "hijo2");
    cout << "" << endl;
    cout << "containsAll(t): " << (containsAll(cAll, t) ? "true" : "false") << endl;

    cout << "" << endl;
    cout << "concatAll(t): " << concatAll(t) << endl;



}
