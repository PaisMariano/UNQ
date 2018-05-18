#include "test_tree.h"

// PROPOSITO: DEVUELVE LA CANTIDAD DE NODOS
// EFICIENCIA: O(n2) donde n es la cantidad de elementos del array . por cada elemento del arrayList se buscan sus hijos
int sizeT(GenTree t) {
    int r = 1;
    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++)
        {
            r += sizeT(getAt(ts, i));
        }
    return r;
}

//PROPOSITO : AGREGA LOS ELEMENTOS DE LA SEGUNDA LISTA A LA PRIMERA
// EFICIENCIA: O(n) siendo n la cantidad de elementos de la lista. es 0(n) ya que por cada elemento de la lista ,el snoc vale O(1)
void agregar (List l1, List l2)
{
    ListIterator listAAgregar =  initIt (l2);
    List listInicial =  (l1);

    while(!finished(listAAgregar))
        {
            snoc(listInicial,getCurrent(listAAgregar));
            next(listAAgregar);
        }
}

// PROPOSITO: INDICA SI EL ELEMENTO APARECE EN EL ARBOL
//EFICIENCIA: O(N) Siendo n la cantidad de nodos , ya que en el peor caso tiene que recorrer todo el arbol
//ANDA

bool containsT(string x, GenTree t) {

    ArrayList hijos = children(t);
    bool aparicion = (value(t) == x);
    int i;

    for (i=0;i<length(hijos) ; i++ )
        {
           aparicion= aparicion|| containsT(x,getAt(hijos,i));
        }
    return aparicion;

}

// PROPOSITO: INDICA LA CANTIDAD DE VECES QUE APARECE EL ELEMENTO
//ANDA
//EFICIENCIA: O(N) Siendo n la cantidad de nodos , ya que en el peor caso tiene que recorrer todo el arbol buscando el valor x;

int occurrencesT(string x, GenTree t) {

    int cantApariciones=0 ;//= containsT (x,t);
    if (value(t)==x) {cantApariciones++;};
    ArrayList hijos = children(t);

    for (int i=0; i<length(hijos);i++)
        {
            cantApariciones =cantApariciones + occurrencesT (x,(getAt(hijos,i)));
        }
        return cantApariciones;
}

// PROPOSITO: DEVUELVE LA CANTIDAD DE RAMAS
//ANDA
// O(N) Siendo n la cantidad de nodos , ya que para debe recorrer todo el arbol para contar todas las hojas.

int countLeaves(GenTree t) {
    int cantHojas = isLeaf(t);

    ArrayList hijos = children(t);

    for(int i=0; i<length(hijos);i++)
        {
          cantHojas=cantHojas+ countLeaves(getAt(hijos,i)); //si pongo =+ no me suma bien, solo me cuenta 1, si los pongo asi sigue suamndo.
        }
    return cantHojas;
}

// PROPOSITO: DEVUELVE LA ALTURA DEL ARBOL
//ANDA
//EFICIENCIA: O(n2) Siendo n la cantidad de nodos , ya que en el peor caso tiene que recorrer todo el arbol

int heightT(GenTree t) {

    int maxAltura = 0;
    ArrayList hijos = children(t);
    for (int i=0;i<length(hijos);i++)
        {
            maxAltura = max (maxAltura, heightT(getAt(hijos,i)));

        }

    return 1 + maxAltura;
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS DEL ARBOL EN UNA LISTA
// PISTA: HACER UNA SUBTAREA QUE RECIBA UNA LISTA POR PARAMETRO
// PARA PODER MODIFICARLA
//EFICIENCIA: O(n.m) Siendo n la cantidad de nodos del peor arbol, y m la cantidad de elementos de la lista
//ANDA

void toList(GenTree t, List& listDeElem) {
      snoc(listDeElem,(value(t)));
      ArrayList hijos= children(t);
      for (int i=0;i<length(hijos);i++)
        {toList(getAt(hijos,i), listDeElem);}
}


List toList(GenTree t) {
    List listDeElem = nil();
    toList(t, listDeElem);
return listDeElem;
}

// PROPOSITO: DEVUELVE LOS ELEMENTOS QUE ESTAN EN LAS HOJAS
//EFICIENCIA:  O(N ) Siendo n la cantidad de nodos del peor arbol .

void leaves (GenTree t, List& listElem ){
    ArrayList arrayHijos = children(t);

   if (isLeaf(t)) {snoc(listElem,(value(t)));}

   for(int i=0;i<length(arrayHijos); i++)
        {
           leaves(getAt(arrayHijos,i),listElem);
        }
    }

List leaves(GenTree t) {

    List listHijos = nil();
    leaves ( t, listHijos);
    return listHijos;
}

// PROPOSITO: AGREGA TODODS LOS ARBOLES DE LA LISTA
// COMO HIJOS DE "t"
//EFICIENCIA:  O(n.m) Siendo n la cantidad de nodos del array , y m la cantidad de elementos de la lista.

void addChildren(ArrayList ts, GenTree t) {
    int i =0;
    ArrayList arrayAagregar = ts;
    ArrayList arrayHijos= children(t);
    for (i;i<length(arrayAagregar); i++)
        {
            addChildren(arrayHijos,getAt(arrayAagregar,i));
        }

}

// PROPOSITO: DEVUELVE LOS ELEMENTOS DEL NIVEL "n"
//EFICIENCIA: O(n)  siendo n la cantidad de nodos del peor arbol,
void levelN (int n, GenTree t, List& listElem )

  {
    ArrayList hijos = children(t);
    for (int i=0; i<length(hijos);i++)
        {levelN(n-1, getAt(hijos,i),listElem);}
    if (n == 0 )
        {snoc(listElem,value(t));}
   }


List levelN(int n, GenTree t) {

    List listaDeNivel=nil();
    levelN (n,t,listaDeNivel);
    return listaDeNivel;
}

//EFICIENCIA: O(1), ya que la función size tiene eficiencia de O(1).

//PROPOSITO: DADO DOS STRING DEVUELVE EL DE MAYOR LONGITUD.
string maxString(string strl1, string strl2)
{   string s;
    if (strl1.size()>= strl2.size() )
         {s = strl1;}
    else {s=strl2;}
    return s;
}

// PROPOSITO: DEVUELVE EL STRING CON MAYOR LONGITUD
//EFICIENCIA: O(n ) siendo n la cantidad de nodos del arrayList,
string stringWithMaxSize(GenTree t) {
    ArrayList hijos = children(t);
    string hijoMaxSize = value(t);

    for (int i=0; i<length(hijos);i++ )
        {  hijoMaxSize= maxString( hijoMaxSize,stringWithMaxSize(getAt(hijos,i))) ;}

    return hijoMaxSize;
}

//PRECONDICION: CADA POSICION CONTENIDA EN EL ARRAY PERTENECE AL ARBOL
// PROPOSITO: DADO UN ARRAY CON NUMEROS QUE INDICAN UN CAMINO POR EL ARBOL
// DEVUELVE LOS ELEMENTOS QUE SE ENCUENTRAN EN DICHO CAMINO}
//EFICIENCIA:
void elemsInPath (GenTree t,int path [], int pathSize,int i, List elementosEnCamino){

    if(i>=0){
        int posicionARecorrer;
        ArrayList arrayDeHijos = children(t);

        elemsInPath( getAt(arrayDeHijos,path [i]), path, pathSize, i+1, elementosEnCamino);
        snoc(elementosEnCamino,value(t));
    }
}

List elemsInPath(GenTree t,int path [], int pathSize) {
    List elementosEnCamino = nil() ;
    elemsInPath(t,path,pathSize, 0,elementosEnCamino);
    return elementosEnCamino;
}



//EFICIENCIA O(n): ya que tiene que recorrer tanto el primer tree como el segundo
//PROPOSITO: DADOS DOS ARBOLES DEVUELVE EL DE MAYOR ALTURA
GenTree maxAltura (GenTree g1, GenTree g2)
{   GenTree masAlto;
    if ( heightT(g1)>heightT(g2))
         {masAlto=g1;}
    else {masAlto = g2;}
    return masAlto;
 }


// PROPOSITO: DEVUELVE EL ARBOL CON MAYOR ALTURA
// PRECONDICION: LA LISTA NO ESTA VACIA
//EFICIENCIA: 0(N . M) siendo n la cantidad De nodos , tiene que recorrer todo el arbol buscando la maxima altura, siendo n la altura del mismo
GenTree maxHeight(ArrayList ts) {


    ArrayList arboles= ts;
    GenTree arbolMasAlto = getAt(arboles, 0);
    for (int i=1; i<length(arboles);i++)
        {
            arbolMasAlto = maxAltura((getAt(arboles,i)), arbolMasAlto);
        }
    return arbolMasAlto;

}


// PROPOSITO: CONCATENA TODOS LOS STRINGS DEL ARBOL
// EFICIENCIA:O(n) ya que tiene que recorrer toda la lista
string concatAll(GenTree t) {

    string todasLasPalabras = value(t);
    ArrayList hijos =  children(t);

    for (int i=0;i<length(hijos);i++)
        {todasLasPalabras = todasLasPalabras+ concatAll(getAt(hijos,i));}

    return todasLasPalabras;

}


//EFICIENCIA: O(n.m) siendo n la cantidad de elementos del arrayList y m por ir agregando los elementos de la segunda lista a la primera.
// PROPOSITO: DEVUELVE LA CONCATENACION DE LOS ELEMENTOS DE LOS ARBOLES DE LA LISTA
List concatToList(ArrayList ts) {

    ArrayList arrayARecorrer = ts;
    List todasListas=nil();

    for(int i=0;i<length(arrayARecorrer);i++)
        {agregar(todasListas, toList(getAt(ts,i)));}
    return todasListas;

}



//EFICIENCIA:O(n)ya que por cada elemento tiene que consultar  si pertenece al arbol (lo cual es constante)
// PROPOSITO: INDICA SI TODOS LOS ELEMENTOS DE LA LISTA ESTAN EN EL ARBOL

bool containsAll(List elems, GenTree t) {


    ListIterator seContiene = initIt(elems);
    bool pertenecen= true;
    while (!finished(seContiene))
        {
            pertenecen = pertenecen &&containsT(getCurrent(seContiene),t);
            next(seContiene);
        }
    return pertenecen;
}


void testTree() {
    // ACA VAN LOS TEST DE LAS FUNCIONES IMPLEMENTADAS

    GenTree t = leaf("ss");
    for(int i = 0; i < 10; i++) {
        GenTree t2 = leaf("a");
        for(int j = 0; j < 10; j++) {
            addChild(t2, leaf("b"));
        }
        addChild(t, t2);
    }

    cout << "" << endl;
    cout << "level 0:" << endl;
    printList(levelN(0, t));
    cout << "" << endl;
    cout << "level 1:" << endl;
    printList(levelN(1, t));
    cout << "" << endl;
    cout << "level 2:" << endl;
    printList(levelN(2, t));

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
