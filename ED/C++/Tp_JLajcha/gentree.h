#ifndef __GENTREE_H
#define __GENTREE_H

#include <iostream>

using namespace std;

#define T_ELEM_TYPE string


//INVARIANTES DE REPRESENTACION :
//Los GenTree no pueden ser NULL.
//
struct ArrayListHeader;
typedef ArrayListHeader* ArrayList;

struct GNode;
typedef GNode* GenTree;

GenTree leaf(T_ELEM_TYPE s);
bool isLeaf(GenTree t);
T_ELEM_TYPE value(GenTree t);
ArrayList children(GenTree t);
void addChild(GenTree& t, GenTree child);
void destroyTree(GenTree t);





#endif
