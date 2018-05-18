#include "arbol.h"

Tree nodeT(ELEM_TYPE x, Tree t1, Tree t2){

    TNode* newTnode = leaf(x);
    newTnode->left = t1;
    netTnode->right = t2;

    return newTnode
}

Tree emptyT() {
    return NULL;
}

bool isEmptyT(Tree t) {
    return t == NULL;
}

Tree leaf(int x) {
    TNode* node = new TNode;
    node->elem  = x;
    node->left  = NULL;
    node->right = NULL;
    return node;
}

Tree branch(int x, Tree t1, Tree t2) {
    TNode* node = leaf(x);
    node->left  = t1;
    node->right = t2;
    return node;
}

int root(Tree t) {
    return t->elem;
}

Tree left(Tree t) {
    return t->left;
}

Tree right(Tree t) {
    return t->right;
}

Int sumarT(Tree t){
    if isEmptyT(t){
    return 0;
    }else{
    return root(t)+sumarT(left(t))+sumarT(right(t));
    }
}
Int sizeT(Tree t){
    if isEmptyT(t){
    return 0;
    }else{
    return 1+sizeT(left(t))+sizeT(right(t));
    }
}
//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
Tree mapDobleT(Tree t){
    if isEmptyT(t){
    return emptyT();
    }else{

    return nodeT(root(t)*2, mapDobleT(left(t)), mapDobleT(right(t)));
    }
}


//Dado un árbol de enteros devuelve un árbol con el doble de cada número.

Bool perteneceT(ELEM_TYPE x, Tree t){
    if isEmptyT(t){
        return False;
    }else{
        return root(t) == x || perteneceT(left(t)) || perteneceT(right(t));
    }
}


//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
int aparicionesT(ELEM_TYPE x, Tree t){
    i = 0;
    if isEmptyT(t){
        return 0;
    }else{
        if root(t)== x;
        i = 1;
        return i + aparicionesT(left(t)) + aparicionesT(right(t));
    }
}
//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
int promedioEdadesT (Tree t){
    return calcEdades(t) / sizeT(t);
}
