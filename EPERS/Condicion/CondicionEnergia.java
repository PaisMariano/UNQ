package ar.edu.unq.epers.bichomon.backend.model.Condicion;

import ar.edu.unq.epers.bichomon.backend.model.bicho.Bicho;
import ar.edu.unq.epers.bichomon.backend.model.entrenador.Entrenador;

public class CondicionEnergia extends CondicionEvolutiva {

    private int energia;

    public CondicionEnergia(int energia){
        this.energia = energia;
    }

    @Override
    public boolean puedeEvolucionar(Entrenador entrenador, Bicho bicho) {
        return false;
    }
}
