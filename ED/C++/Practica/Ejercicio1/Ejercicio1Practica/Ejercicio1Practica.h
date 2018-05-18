#include <iostream>
#define ELEM_TYPE int

using namespace std;

struct Poke {
    string nombre;
    int vida;

};
typedef Poke* Pokemon;

Pokemon crearPokemon(string nombre, int vida);
string getNombre(Pokemon p);
int getVida(Pokemon p);
void cambiarNombre(Pokemon& p, string nombre);
bool estaVivo(Pokemon p);
void restarVida(Pokemon& p);
//Le resta una unidad a la vida.
void lucharN(int n, Pokemon& p, Pokemon& r);
//Le resta vida “n” veces a los dos pokemones. Pensar una solución que sea O(n) y otra que sea O(1).
void destruir(Pokemon& p);
//Libera memoria


struct May{
    int Just;
    int Nothing;
};

typedef May* Maybe;
//Definir el tipo abstracto Maybe utilizando una interfaz destructiva (operaciones nothing, just,
//fromJust e isNothing).
