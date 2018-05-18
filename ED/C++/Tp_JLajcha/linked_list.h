#include <iostream>

using namespace std;

#define ELEM_TYPE string

struct ListNode;
struct ListHeader;
typedef ListHeader* List;

List nil();                // O(1)
bool isNil(List q);        // O(1)
void snoc(List& q, ELEM_TYPE x); // O(1)
ELEM_TYPE head(List q);          // O(1)
void tail(List& q);        // O(1)
int length(List q);            // O(1)
void printList(List q);          // O(n)
void destroyList(List& q);       // O(n)

typedef ListNode* ListIterator;

ListIterator initIt(List q); // O(1)
bool finished(ListIterator it); // O(1)
ELEM_TYPE getCurrent(ListIterator it); // O(1)
void setCurrent(ELEM_TYPE x, ListIterator it); // O(1)
void next(ListIterator& it); // O(1)