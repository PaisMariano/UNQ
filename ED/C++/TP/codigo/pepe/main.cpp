#include <iostream>
#include "gentree.h"
#include "array_list.h"
#include "linked_list.h"
#include "md5.h"
#include "test_tree.h"

using namespace std;

///O(n^m): Siendo n vocabSize y m maxLevel.
void generate(string vocab[], int vocabSize, int maxLevel, int level, GenTree& t) {
    GenTree hijo;
    if (maxLevel > level){
        for(int i=0; i<vocabSize; i++){
            hijo = leaf(value(t)+vocab[i]);
            addChild(t, hijo);
            generate(vocab, vocabSize, maxLevel, level+1, hijo);
        }
    }
}

GenTree generate(string vocab[], int vocabSize, int maxLevel) {
  GenTree t = leaf("");
  generate(vocab, vocabSize, maxLevel, 0, t);
  return t;
}
///O(n): Donde n es el tamaño de ts.
void allPasswords(GenTree t, List& xs) {

    ArrayList ts = children(t);

    if (length(ts) == 0)
        snoc(xs, value(t));

    for(int i = 0; i < length(ts); i++)
        allPasswords(getAt(ts, i), xs);

}


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
    //string vocab[3];
    //vocab[0] = "a";
    //vocab[1] = "b";
    //vocab[2] = "c";
    //GenTree t = generate(vocab, 3, 3);
    //List ts = nil();
    //int len = 8;
    //int vocabSize = 7;
    //string vocab[] = {"3","4","c","g","h", "m", "n"};
    //GenTree t = generate(vocab, vocabSize, len);
    //printList(toList(t));
    //allPasswords(t);

    testTree();
    //testCrack();
  return 0;
}
