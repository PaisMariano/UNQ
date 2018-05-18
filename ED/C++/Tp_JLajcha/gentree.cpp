#include "gentree.h"
#include "array_list.h"

struct GNode
{
  T_ELEM_TYPE elem;
  ArrayList children;
};
//EFICIENCIA : O(1)
GenTree leaf(T_ELEM_TYPE x)
{
    GNode* hoja;
    hoja = new GNode;
    hoja-> elem = x;
    hoja->children = crearArrayList();
    return hoja;
}

//EFICIENCIA: O(1) ya que no tiene que hacer ningun recorrido
bool isLeaf(GenTree t)
{
  return isEmpty(t->children);
}

//EFICIENCIA O(1)
T_ELEM_TYPE value(GenTree t)
{
  return t->elem;
}

//EFICIENCIA O(1) ya que devuelve el array que ya se encuentra dentro de la estructura.
ArrayList children(GenTree t)
{
  return t-> children;
}

//EFICIENCIA:O(1) "amortizado", ya que en la mayoria de los casos  solo agrega (que es O(1)) pero en el caso de tener que agrandar el array, cuentar n.por la poca frecuencia se puede llamar
void addChild(GenTree& t, GenTree child)
{
  add((t->children),child);
}


//EFICIENCIA:O(n) Donde n son las cantidad de nodos contenidos en el array de los hijos
void destroyTree(GenTree t)
{
  int i;
  ArrayList hijos = t->children;
  for (i=0;i<length(hijos) ;i++)
    {
      destroyTree (getAt(hijos,i));
    }
  destroyArrayList(t->children);
  delete t;
  t = NULL ;
}
