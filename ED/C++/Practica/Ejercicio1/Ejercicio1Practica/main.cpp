#include <iostream>
#include "Ejercicio1Practica.h"

using namespace std;

int main()
{
    Pokemon p = crearPokemon("Charmander", 100);
    Pokemon v = crearPokemon("Pikachu", 100);
    cout << p << endl;
    cout << getNombre(p) << endl;
    cout << getVida(p) << endl;
    cambiarNombre(p, "Bulbasaur");
    cout << estaVivo(p) << endl;
    restarVida(p);
    cout << getVida(p) << endl;

    lucharN(50, p, v);
    cout << getVida(p) << endl;
    cout << getVida(v) << endl;

    destruir(p);
    cout << getVida(p) << endl;

    return 0;
}
