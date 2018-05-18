#include <iostream>
#include "Ejercicio2Practica.h"

int sumar(List xs){
    int sum = 0;
    while (not isNil(xs)){
        sum += head(xs);
        tail(xs);
    }
    return sum;
}
int length(List xs){
    int cant = 0;
    while (not isNil(xs)){
        cant += 1;
        tail(xs);
    }
    return cant;
}

List mapSucc(List xs){
    List ys = Nil();
    while (not isNil(xs)){
        Snoc(ys, head(xs)+1);
        tail(xs);
    }
    return ys;
}
List take(int n, List xs){
    List ys = Nil();
    int i = 0;
        for (i=0;i<n;i++){
            Snoc(ys, head(xs));
            tail(xs);
        }
    return ys;
}

List drop(int n, List xs){
    List ys = Nil();
    int i = 0;
        for (i=0;i<n;i++){
            if (not isNil(xs)){
            Snoc(ys, head(xs));
            tail(xs);
            }
        }
    return ys;
}

