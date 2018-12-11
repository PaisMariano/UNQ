package ar.edu.unq.epers.bichomon.backend.model.Condicion;

import ar.edu.unq.epers.bichomon.backend.model.bicho.Bicho;
import ar.edu.unq.epers.bichomon.backend.model.entrenador.Entrenador;

public class CondicionEdad extends CondicionEvolutiva {

    private int edad;

    @Override
    public boolean puedeEvolucionar(Entrenador entrenador, Bicho bicho) {
        return true;
    }

}
