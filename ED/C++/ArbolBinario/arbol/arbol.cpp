#include <iostream>
#include "arbol.h"

int sumarT(Tree t){

    Queue losQueFaltan = emptyQ();
    enqueue(t, losQueFaltan);
    int total = 0;
    while (not(isEmptyQ(losQueFaltan))){
        Tree actual  = firstQ(losQueFaltan);
        dequeue(losQueFaltan);
        if(not( isEmptyT(actual))){
            total+=root(actual);
            enqueue(right(actual), losQueFaltan);
            enqueue(left(actual), losQueFaltan);
        }
    }
    return total;
}

//Dado un árbol binario de enteros devuelve la suma entre sus elementos.
int sizeT(Tree t){
    Queue losQueFaltan = emptyQ();
    enqueue(t, losQueFaltan);
    int sum = 0;
    while (not(isEmptyQ(losQueFaltan))){
        Tree actual  = firstQ(losQueFaltan);
        dequeue(losQueFaltan);
        if(not(isEmptyT(actual))){
            sum++;
            enqueue(right(actual), losQueFaltan);
            enqueue(left(actual), losQueFaltan);
        }
    }
    return sum;
}

//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
//Tree mapDobleT(Tree t){

//Dado un árbol de enteros devuelve un árbol con el doble de cada número.
//Tree mapLongitudT(Tree t){

//Dado un árbol de palabras devuelve un árbol con la longitud de cada palabra.
bool perteneceT(ELEM_TYPE x, Tree t){
    Queue losQueFaltan = emptyQ();
    enqueue(t, losQueFaltan);
    int cond = false;
    while (not(isEmptyQ(losQueFaltan))&& (not cond)){
        Tree actual  = firstQ(losQueFaltan);
        dequeue(losQueFaltan);
        if(not isEmptyT(actual)){
            cond = root(actual) == x;
            enqueue(right(actual), losQueFaltan);
            enqueue(left(actual), losQueFaltan);
        }
    }
    return cond;
}

//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
int aparicionesT(ELEM_TYPE x, Tree t){
    Queue losQueFaltan = emptyQ();
    enqueue(t, losQueFaltan);
    int sum = 0;
    while (not(isEmptyQ(losQueFaltan))){
        Tree actual  = firstQ(losQueFaltan);
        dequeue(losQueFaltan);
        if(not(isEmptyT(actual)) && x == root(actual)){
            sum++;
            enqueue(right(actual), losQueFaltan);
            enqueue(left(actual), losQueFaltan);
        }
    }
    return sum;
}


//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
int promedioEdadesT (Tree t){
    Queue losQueFaltan = emptyQ();
    enqueue(t, losQueFaltan);
    int sum = 0;
    int cant = 0;
    while (not(isEmptyQ(losQueFaltan))){
        Tree actual  = firstQ(losQueFaltan);
        dequeue(losQueFaltan);
        if(not(isEmptyT(actual))){
            cant++;
            sum+= root(actual);
            enqueue(right(actual), losQueFaltan);
            enqueue(left(actual), losQueFaltan);
        }
    }
    return (sum / cant);
}
