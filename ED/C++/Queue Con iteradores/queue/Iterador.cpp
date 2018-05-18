#define ELEM_TYPE int
#include <iostream>
#include <stdio.h>
#include <malloc.h>

//#include "..\Prelude\Prelude.h"
#include "Iterador.h"

using namespace std;

struct queueNode;
struct queueHeader;
typedef queueHeader* Queue;



Queue emptyQ()               // O(1)
{
    queueHeader* newQueue = new queueHeader;

    newQueue -> first = NULL;
    newQueue -> last  = NULL;
    newQueue -> it    = 0;

    return newQueue;
}

bool isEmptyQ(Queue q)        // O(1)
{
    return q->it == 0;
}
void enqueue(ELEM_TYPE x, Queue& q) // O(1)
{
    queueNode* newNode = new queueNode;
    newNode->value = x;
    newNode->next  = 0;

    if (q->first == NULL){
        q->first = newNode;
    } else{
        q->last->next = newNode;
    }
    q->last = newNode;
    q->it++;
}


ELEM_TYPE  firstQ(Queue q)          // O(1)
{
    return q->first->value;
}

void dequeue(Queue& q)        // O(1)
{   queueNode* tempNode = new queueNode;
    if (not (q->first == NULL)){
        tempNode = q -> first;
        q -> first = q -> first -> next;
        delete tempNode;
    }
    if(q->it == 1) {
        q->last = NULL;
    }
    q -> it--;
}

int sizeQ(Queue q)           // O(1)
{
    return q->it;
}

void printQ(Queue q) //O(n)
{
    queueNode* actual = q->first;
    cout << "Queue [ ";
    while(actual != NULL)
    {
        if(actual->next != NULL)
        {
             cout << actual->value << ", ";
        }
        else
        {
           cout << actual->value << " ";
        }
        actual = actual->next;
    }
    cout << "]" << endl;
}

Queue copyQ(Queue q)        // O(n)
{
    Queue result = emptyQ();
    QIterator qI = initQIt(q);
    while (not finishedQIt(qI))
    {
        enqueue(getCurrentQIt(qI), result);
        cout << qI->next << endl;
        nextQIt(qI);
    }
    return result;
}



void destroyQ(Queue& q)       // O(n)
{
    while (q->it > 0)
    {
        dequeue(q);
    }

    delete q;
    q = NULL; //borro el puntero del usuario a la Queue.
}


typedef queueNode* QIterator;

QIterator initQIt(Queue q) // O(1)
{return q->first;}

bool finishedQIt(QIterator it) // O(1)
    { return it->next == 0;
            }
ELEM_TYPE getCurrentQIt(QIterator it) // O(1)
    { return it->value;
            }
void setCurrentQIt(ELEM_TYPE x, QIterator it) // O(1)
    {  it->value = x;
        }
void nextQIt(QIterator& it)
    {it->next;}// O(1)
