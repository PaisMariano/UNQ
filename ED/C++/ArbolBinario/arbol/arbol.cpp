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

//Dado un �rbol binario de enteros devuelve la suma entre sus elementos.
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

//Dado un �rbol binario devuelve su cantidad de elementos, es decir, el tama�o del �rbol (size en ingl�s).
//Tree mapDobleT(Tree t){

//Dado un �rbol de enteros devuelve un �rbol con el doble de cada n�mero.
//Tree mapLongitudT(Tree t){

//Dado un �rbol de palabras devuelve un �rbol con la longitud de cada palabra.
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

//Dados un elemento y un �rbol binario devuelve True si existe un elemento igual a ese en el �rbol.
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


//Dados un elemento e y un �rbol binario devuelve la cantidad de elementos del �rbol que son iguales a e.
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
