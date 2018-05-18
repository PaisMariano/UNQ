#include <iostream>

#include "Queue.h"

#define ELEM_TYPE Tree

using namespace std;


int sumarT(Tree t);
//Dado un árbol binario de enteros devuelve la suma entre sus elementos.
int sizeT(Tree t);
//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
Tree mapDobleT(Tree t);
//Dado un árbol de enteros devuelve un árbol con el doble de cada número.
Tree mapLongitudT(Tree t);
//Dado un árbol de palabras devuelve un árbol con la longitud de cada palabra.
bool perteneceT(ELEM_TYPE x, Tree t);
//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
int aparicionesT(ELEM_TYPE x, Tree t);
//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
int promedioEdadesT (Tree t);
//Dado un árbol de personas devuelve el promedio entre las edades de todas las personas. Definir las subtareas que sean necesarias para

