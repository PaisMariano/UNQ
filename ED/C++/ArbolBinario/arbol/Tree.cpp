#include "Tree.h"

Tree emptyT() {
    return NULL;
}

bool isEmptyT(Tree t) {
    return t == NULL;
}

Tree leaf(int x) {
    TNode* node = new TNode;
    node->elem  = x;
    node->left  = NULL;
    node->right = NULL;
    return node;
}

Tree branch(int x, Tree t1, Tree t2) {
    TNode* node = leaf(x);
    node->left  = t1;
    node->right = t2;
    return node;
}

int root(Tree t) {
    return t->elem;
}

Tree left(Tree t) {
    return t->left;
}

Tree right(Tree t) {
    return t->right;
}

void destroyT(Tree& t) {
    if(t != NULL) {
        destroyT(t->left);
        destroyT(t->right);
        delete t;
        t = NULL;
    }
}
