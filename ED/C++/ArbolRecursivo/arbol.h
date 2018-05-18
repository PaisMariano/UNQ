#define ELEM_TYPE int;
#include <iostream>
using namespace std;

struct TNode {
    int elem;
    TNode* left;
    TNode* right;
};
typedef TNode* Tree;

Tree nodeT(ELEM_TYPE x, Tree t1, Tree t2);

Tree emptyT();
bool isEmptyT(Tree t);
Tree leaf(int x); // crea una hoja
Tree branch(int x, Tree t1, Tree t2);
int root(Tree t);
Tree left(Tree t);
Tree right(Tree t);


Int sumarT(Tree t);
//Dado un �rbol binario de enteros devuelve la suma entre sus elementos.
Int sizeT(Tree t);
//Dado un �rbol binario devuelve su cantidad de elementos, es decir, el tama�o del �rbol (size en ingl�s).
Tree mapDobleT(Tree t);
//Dado un �rbol de enteros devuelve un �rbol con el doble de cada n�mero.
Tree mapLongitudT(Tree t) :: Tree String -> Tree Int
//Dado un �rbol de palabras devuelve un �rbol con la longitud de cada palabra.
Bool perteneceT(ELEM_TYPE x, Tree t);
//Dados un elemento y un �rbol binario devuelve True si existe un elemento igual a ese en el �rbol.
int aparicionesT(ELEM_TYPE x, Tree t);
//Dados un elemento e y un �rbol binario devuelve la cantidad de elementos del �rbol que son iguales a e.
int promedioEdadesT (Tree t);
//Dado un �rbol de personas devuelve el promedio entre las edades de todas las personas. Definir las subtareas que sean necesarias para
