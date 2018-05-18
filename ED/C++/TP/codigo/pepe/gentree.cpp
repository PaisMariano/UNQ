#include "gentree.h"
#include "array_list.h"

//FALTAN DEFINIR PRECONDICIONES!

struct GNode
{
  T_ELEM_TYPE elem;
  ArrayList children;
};
typedef GNode* GenTree;

GenTree leaf(T_ELEM_TYPE x)
{
    GNode* NewNode = new GNode;
    NewNode->elem  = x;
    NewNode->children = crearArrayList();

    return NewNode;
}
///O(1) es constante siempre tarda lo mismo en saber si es hoja.
bool isLeaf(GenTree t)
{
    return isEmpty(t->children);
}
///O(1) es constante siempre tarda lo mismo en traer el elemento.
T_ELEM_TYPE value(GenTree t)
{
    return t->elem;
}
///O(1) es constante siempre tarda lo mismo en traer los hijos.
ArrayList children(GenTree t)
{
  return t->children;
}
///O(1) amortizado, es constante en la mayoria de los casos.
void addChild(GenTree& t, GenTree child)
{
  add(t->children, child);
}
///O(n) es lineal realiza la recursion y recorre la ArrayList de hijos.
void destroyTree(GenTree t)
{
    ArrayList ts = children(t);
    for(int i = 0; i < length(ts); i++)
    destroyTree(getAt(ts, i));

    destroyArrayList(t->children);
    delete t;
}
