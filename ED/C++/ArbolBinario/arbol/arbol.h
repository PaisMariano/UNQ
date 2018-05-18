#include <iostream>

#include "Queue.h"

#define ELEM_TYPE Tree

using namespace std;


int sumarT(Tree t);
//Dado un �rbol binario de enteros devuelve la suma entre sus elementos.
int sizeT(Tree t);
//Dado un �rbol binario devuelve su cantidad de elementos, es decir, el tama�o del �rbol (size en ingl�s).
Tree mapDobleT(Tree t);
//Dado un �rbol de enteros devuelve un �rbol con el doble de cada n�mero.
Tree mapLongitudT(Tree t);
//Dado un �rbol de palabras devuelve un �rbol con la longitud de cada palabra.
bool perteneceT(ELEM_TYPE x, Tree t);
//Dados un elemento y un �rbol binario devuelve True si existe un elemento igual a ese en el �rbol.
int aparicionesT(ELEM_TYPE x, Tree t);
//Dados un elemento e y un �rbol binario devuelve la cantidad de elementos del �rbol que son iguales a e.
int promedioEdadesT (Tree t);
//Dado un �rbol de personas devuelve el promedio entre las edades de todas las personas. Definir las subtareas que sean necesarias para

