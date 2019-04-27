package Model

import org.uqbar.commons.model.annotations.Observable

@Observable
public class CalculatorModel {

    var firstNumber: Double  = 0.0;
    var secondNumber: Double = 0.0;
    var result: Double = 0.0;

    fun divide() : Unit {
        if (secondNumber != 0.0){
            result = firstNumber / secondNumber;
        }
    }

    fun multiply() : Unit {
        result = firstNumber * secondNumber;
    }

    fun add() : Unit{
        result = firstNumber + secondNumber;
    }

    fun substract() : Unit {
        result = firstNumber - secondNumber;
    }
}