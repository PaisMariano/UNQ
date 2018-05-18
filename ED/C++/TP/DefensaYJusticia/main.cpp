#include <iostream>
#include "gentree.h"
#include "array_list.h"
#include "linked_list.h"
#include "md5.h"
#include "test_tree.h"

using namespace std;

bool empiezaCon(char c, string s) {
     return s[0] == c;
}
string charToString(char c) {
     return string(1, c);
}
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
void allPasswords(GenTree t, List& xs, char letra) {

    if (empiezaCon(letra, value(t))){
        snoc(xs, value(t));
        }

    ArrayList ts = children(t);

    for(int i = 0; i < length(ts); i++){
        allPasswords(getAt(ts, i), xs, letra);
    }
}


List allPasswords(GenTree t, char letra) {
  List xs = nil();
  allPasswords(t, xs, letra);
  return xs;
}

void crack(string vocab[], int vocabSize, int len, string enc_passwd, char letra) {
  GenTree t = generate(vocab, vocabSize, len);
  List passwords = allPasswords(t, letra);
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
    int len = 5;
    int vocabSize = 4;
    string vocab[] = {"h","o","l","a"};
    string enc_passwd = "4d186321c1a7f0f354b297e8914ab240";
    crack(vocab, vocabSize, len, enc_passwd, 'h');
  }

  {
    int len = 4;
    int vocabSize = 3;
    string vocab[] = {"y","o","s"};
    string enc_passwd = "91a5c1de1fb151b6924cbefa6e68fb9b";
    crack(vocab, vocabSize, len, enc_passwd, 's');
  }

  {
    int len = 7;
    int vocabSize = 5;
    string vocab[] = {"l","e","d","i","f"};
    string enc_passwd = "fa1776fe544c44fad1cf2bec71a14464";
    crack(vocab, vocabSize, len, enc_passwd, 'f');
  }

  {
    int len = 7;
    int vocabSize = 5;
    string vocab[] = {"m","u","a","j","a"};
    string enc_passwd = "64506fe09a243b672cd7aaacab88cdd5";
    crack(vocab, vocabSize, len, enc_passwd, 'm');
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

    //testTree();
    testCrack();
  return 0;
}
