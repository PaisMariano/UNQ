#include "linked_list.h"

struct ListNode
{
    ELEM_TYPE elem;
    ListNode* next;
};

struct ListHeader
{
    int tam;
    ListNode* first;
    ListNode* last;
};

/* Inv. Rep.
    + tam es la cantidad de nodos entre first y last
    + first es NULL sii last es NULL
    + List no es NULL
*/

List nil()
{
    ListHeader* h = new ListHeader;
    h->first = NULL;
    h->last  = NULL;
    h->tam   = 0;
    return h;
}

bool isNil(List xs)
{
    return xs->first == 0;
}

void snoc(List& xs, ELEM_TYPE x)
{
    ListNode* newNode = new ListNode;
    newNode->elem = x;
    newNode->next = NULL;

    if(xs->tam == 0)
    {
        xs->first = newNode;
        xs->last  = newNode;
    }
    else
    {
        xs->last->next = newNode;
        xs->last = newNode;
    }

    xs->tam++;
}

ELEM_TYPE head(List xs)
{
    return xs->first->elem;
}

void tail(List& xs)
{
    if(xs->tam == 1)
    {
        delete xs->first;
        xs->first = NULL;
        xs->last  = NULL;
    }
    else
    {
        ListNode* tmp = xs->first->next;
        delete xs->first;
        xs->first = tmp;
    }

    xs->tam--;
}

int length(List xs)
{
    return xs->tam;
}

void printList(List xs)
{
    ListNode* actual = xs->first;
    cout << "List [ ";
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

List copiar(List xs)
{
    ListNode* actual = xs->first;
    List r = nil();
    while(actual != NULL)
    {
        snoc(r, actual->elem);
        actual = actual->next;
    }
    return r;
}

void destroyList(List& xs)
{
    while(!isNil(xs))
    {
        tail(xs);
    }
    delete xs;
    xs = NULL;
}

ListIterator initIt(List q)
{
    return q->first;
}

bool finished(ListIterator it)
{
    return it == NULL;
}

ELEM_TYPE getCurrent(ListIterator it)
{
    return it->elem;
}

void setCurrent(ELEM_TYPE x, ListIterator it)
{
    it->elem = x;
}

void next(ListIterator& it)
{
    it = it->next;
}
