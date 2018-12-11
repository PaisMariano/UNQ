package ar.edu.unq.epers.bichomon.backend.model.Condicion;

import ar.edu.unq.epers.bichomon.backend.model.bicho.Bicho;
import ar.edu.unq.epers.bichomon.backend.model.entrenador.Entrenador;

public abstract class CondicionEvolutiva {

    public abstract boolean puedeEvolucionar(Entrenador entrenador, Bicho bicho);

}
