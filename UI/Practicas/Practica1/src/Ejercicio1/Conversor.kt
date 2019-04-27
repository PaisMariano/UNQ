package Ejercicio1

class Conversor(){

    var exponenteKm: Double = 0.621371
    var exponenteMillas: Double = 1.60934

    fun cambiarMillasAKm(cantMilla: Double): Double{

        return cantMilla * exponenteMillas
    }

    fun cambiarKmAMillas(cantKm: Double): Double{

        return cantKm * exponenteKm
    }

}