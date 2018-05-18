#include <iostream>
#define ELEM_TYPE int
#include <stdio.h>
#include <malloc.h>

//#include "..\Prelude\Prelude.h"
#include "Iterador.h"

using namespace std;

int main()
{
    int y = 5;
    Queue x = emptyQ();

    cout << "Enqueue x2" << endl;
    enqueue(y,x);
    enqueue(y,x);
    enqueue(y,x);
    enqueue(y,x);

    cout << " " << endl;
    cout << "isEmpty()" << endl;
    cout << isEmptyQ(x) << endl;

    cout << " " << endl;
    cout << "firstQ()" << endl;
    cout << firstQ(x) << endl;

    cout << " " << endl;
    cout << "first" << endl;
    cout << x->first << endl;
    cout << "last" << endl;
    cout << x->last << endl;
    cout << "iterador" << endl;
    cout << x->it << endl;

    cout << " " << endl;
    cout << "printQ()" << endl;
    printQ(x);

    cout << " " << endl;
    cout << "dequeue()" << endl;
    dequeue(x);

    cout << " " << endl;
    cout << "first" << endl;
    cout << x->first << endl;
    cout << "last" << endl;
    cout << x->last << endl;
    cout << "iterador" << endl;
    cout << x->it << endl;


    cout << " " << endl;
    cout << "printQ()" << endl;
    printQ(x);

    cout << " " << endl;
    cout << "sizeQ()" << endl;
    cout << sizeQ(x) << endl;

    cout << " " << endl;
    cout << "copyQ()" << endl;
    Queue z = copyQ(x);

    cout << " " << endl;
    cout << "printQ() del copiado (z)" << endl;
    //printQ(z);

    cout << " " << endl;
    cout << "first de z" << endl;
    cout << x->first << endl;
    cout << "last de z" << endl;
    cout << x->last << endl;
    cout << "iterador de z" << endl;
    cout << x->it << endl;

    cout << " " << endl;
    cout << "DestroyQ()" << endl;
    destroyQ(x);

    cout << " " << endl;
    cout << "printQ()" << endl;
    //printQ(x);  //EXPLOTA PORQUE YA NO ESTA EN MEMORIA.


    return 0;
}
