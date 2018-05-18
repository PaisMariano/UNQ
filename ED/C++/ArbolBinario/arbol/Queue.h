#include "Tree.h"
#define ELEM_TYPE Tree
#include <iostream>


using namespace std;

struct QueueNode;
struct QueueHeader;
typedef QueueHeader* Queue;

Queue emptyQ();                // O(1)
bool isEmptyQ(Queue q);        // O(1)
void enqueue(ELEM_TYPE x, Queue& q); // O(1)
Tree firstQ(Queue q);          // O(1)
void dequeue(Queue& q);        // O(1)
int sizeQ(Queue q);            // O(1)
void printQ(Queue q);          // O(n)
Queue copyQ(Queue q);          // O(n)
void destroyQ(Queue& q);       // O(n)

typedef QueueNode* QIterator;

QIterator initQIt(Queue q); // O(1)
bool finishedQIt(QIterator it); // O(1)
ELEM_TYPE getCurrentQIt(QIterator it); // O(1)
void setCurrentQIt(ELEM_TYPE x, QIterator it); // O(1)
void nextQIt(QIterator& it); // O(1)
