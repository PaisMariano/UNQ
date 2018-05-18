#include <iostream>
#include "Ejercicio1Practica.h"

using namespace std;

Pokemon crearPokemon(string nombre, int vida){
    Poke* poke = new Poke;
    poke->nombre = nombre;
    poke->vida   = vida;

    return poke;
}
string getNombre(Pokemon p){
    return p->nombre;
}
int getVida(Pokemon p){
    return p->vida;
}
void cambiarNombre(Pokemon& p, string nombre){
    p->nombre = nombre;
}
bool estaVivo(Pokemon p){
    return p->vida > 0;
}
void restarVida(Pokemon& p){
    p->vida -= 1;
}
//Le resta una unidad a la vida.
void lucharN(int n, Pokemon& p, Pokemon& r){
    //p->vida -= n;
    //r->vida -= n;     //o(1)

    int i = 0;
    while (i < n){
        i++;
        restarVida(p);
        restarVida(r);
    }
}
//Le resta vida “n” veces a los dos pokemones. Pensar una solución que sea O(n) y otra que sea O(1).
void destruir(Pokemon& p){
    delete p;
    p = NULL;
}
//Libera memoria


