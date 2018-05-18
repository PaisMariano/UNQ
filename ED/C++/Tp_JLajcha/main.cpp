#include <iostream>
#include "gentree.h"
#include "array_list.h"
#include "linked_list.h"
#include "md5.h"
#include "test_tree.h"

using namespace std;
//PROPOSITO:
//EFICIENCIA: O(n.m) siendo n la cantidad de elementos del array de vocabulario, y m la cantidad de nodos del peor arbol

void generate(string vocab[], int vocabSize, int maxLevel, int level, GenTree& t) {

  if (maxLevel>0){
    for (int i = 0; i<vocabSize; i++)
        { addChild(t,leaf(value(t)+vocab[i])); }

    ArrayList hijos= children(t);
    for (int j=0;j<length(hijos); j++)
        {
            GenTree x = getAt(hijos,j);
            generate(vocab,vocabSize,maxLevel-1,level,x);
        }
    }

 }


//EFICIENCIA: O(n.m) , ya que el procedimiento generate tiene ese costo.
//PROPOSITO: DEVUELVE EL ARBOL DADO UN VOCABULARIO DETERMINADO

GenTree generate(string vocab[], int vocabSize, int maxLevel) {
  GenTree t = leaf("");
  generate(vocab, vocabSize, maxLevel, 0, t);
  return t;
}



//EFICIENCIA: O(n) siendo n la cantidad de elementos de nodos  del peor arbol.
void allPasswords(GenTree t, List& xs) {

    ArrayList arrayHijos = children(t);
    int i=0;
    if (isLeaf(t)) {snoc(xs,(value(t)));}

    for(i;i<length(arrayHijos); i++)
        {
             allPasswords((getAt(arrayHijos,i)),xs);

        }

}



//PROPOSITO: DEVUELVE LA CONCATENACION DE LAS CONTRASEÑAS GENERADAS EN UNA LISTA
//EFICIENCIA: O(n) ya que utiliza el procedimiento allPasswords, que es el mas caro.
List allPasswords(GenTree t) {
  List xs = nil();
  allPasswords(t, xs);
  return xs;
}

void crack(string vocab[], int vocabSize, int len, string enc_passwd) {
  GenTree t = generate(vocab, vocabSize, len);
  List passwords = allPasswords(t);
  MD5 md5;
  bool cracked = false;
  for(ListIterator it = initIt(passwords); not finished(it); next(it)) {
    if (md5.digestString(getCurrent(it)) == enc_passwd) {
      cout << "Password is: " << getCurrent(it) << endl;
      cracked = true;
      break;
    }
  }
  if (not cracked) {
    cout << "You failed to crack the password! Mwa ha ha ha!" << endl;
  }
  destroyTree(t);
}

void testCrack() {
  {
    int len = 3;
    int vocabSize = 3;
    string vocab[] = {"a","b","c"};
    string enc_passwd = "900150983cd24fb0d6963f7d28e17f72";
    crack(vocab, vocabSize, len, enc_passwd);
  }

  {
    int len = 7;
    int vocabSize = 6;
    string vocab[] = {"a","c","e","k","m","r"};
    string enc_passwd = "33c5d4954da881814420f3ba39772644";
    crack(vocab, vocabSize, len, enc_passwd);
  }

  {
    int len = 7;
    int vocabSize = 5;
    string vocab[] = {"a","i","k","r","s"};
    string enc_passwd = "7c6b4ede856124ddd230682fda4171e9";
    crack(vocab, vocabSize, len, enc_passwd);
  }

  {
    int len = 8;
    int vocabSize = 7;
    string vocab[] = {"3","4","c","g","h", "m", "n"};
    string enc_passwd = "5175607e634414bc9b7790bf6f018cda";
    crack(vocab, vocabSize, len, enc_passwd);
  }
}


int main() {
  int len = 8;
    int vocabSize = 7;
    string vocab[] = {"3","4","c","g","h", "m", "n"};

 //generate( vocab,  vocabSize,len);
 //  testTree();
testCrack();
// testCrack();
  return 0;
}
