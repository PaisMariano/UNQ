#include "Queue.h"

struct QueueNode
{
    ELEM_TYPE elem;
    QueueNode* next;
};

struct QueueHeader
{
    int tam;
    QueueNode* first;
    QueueNode* last;
};

/* Inv. Rep.
    + tam es la cantidad de nodos entre first y last
    + first es NULL sii last es NULL
    + Queue jamás es NULL
*/

Queue emptyQ()
{
    QueueHeader* q = new QueueHeader;
    q->first = NULL;
    q->last  = NULL;
    q->tam   = 0;
    return q;
}

bool isEmptyQ(Queue q)
{
    return q->first == 0;
}

void enqueue(ELEM_TYPE x, Queue& q)
{
    QueueNode* nuevoQ = new QueueNode;
    nuevoQ->elem = x;
    nuevoQ->next = NULL;

    if(q->tam == 0)
    {
        q->first = nuevoQ;
        q->last  = nuevoQ;
    }
    else
    {
        q->last->next = nuevoQ;
        q->last = nuevoQ;
    }

    q->tam++;
}

ELEM_TYPE firstQ(Queue q)
{
    return q->first->elem;
}

// PARCIAL EN EL EMPTYQ
void dequeue(Queue& q)
{
    if(q->tam == 1)
    {
        delete q->first;
        q->first = NULL;
        q->last  = NULL;
    }
    else
    {
        QueueNode* tmp = q->first->next;
        delete q->first;
        q->first = tmp;
    }

    q->tam--;
}

int sizeQ(Queue q)
{
    return q->tam;
}

void printQ(Queue q)
{
    QueueNode* actual = q->first;
    cout << "Queue [ ";
    while(actual != NULL)
    {
        if(actual->next != NULL)
        {
             cout << actual->elem << ", ";
        }
        else
        {
           cout << actual->elem << " ";
        }
        actual = actual->next;
    }
    cout << "]" << endl;
}

Queue copyQ(Queue q)
{
    QueueNode* actual = q->first;
    Queue r = emptyQ();
    while(actual != NULL)
    {
        enqueue(actual->elem, r);
        actual = actual->next;
    }
    return r;
}

void destroyQ(Queue& q)
{
    while(!isEmptyQ(q))
    {
        dequeue(q);
    }
    delete q;
    q = NULL;
}

QIterator initQIt(Queue q) {
    return q->first;
}

bool finishedQIt(QIterator it) {
    return it == NULL;
}

ELEM_TYPE getCurrentQIt(QIterator it) {
    return it->elem;
}

void setCurrentQIt(ELEM_TYPE x, QIterator it) {
    it->elem = x;
}

void nextQIt(QIterator& it) {
    it = it->next;
}
