package Ejercicio1

class KilometrosAMillas(){

    var exponenteKm: Double = 0.621371

    fun cambiarKmAMillas(cantKm: Double): Double{

        return cantKm * exponenteKm
    }

}