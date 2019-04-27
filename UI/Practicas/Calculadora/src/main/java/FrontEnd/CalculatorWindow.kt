package FrontEnd

import Model.CalculatorModel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.MainWindow
import org.uqbar.lacar.ui.model.ControlBuilder

public class CalculatorWindow(lmodel : CalculatorModel) : MainWindow<CalculatorModel>(lmodel){

    override fun createContents(panel: Panel) {

        title = "Calculator";

        Label(panel)
                .setText("Insert first number")
                .alignCenter();
        TextBox(panel)
                .bindValueToProperty<String, ControlBuilder>("firstNumber");

        Label(panel)
                .setText("Insert second number")
                .alignCenter();
        TextBox(panel)
                .bindValueToProperty<String, ControlBuilder>("secondNumber");

        Button(panel)
                .setCaption("Add")
                .onClick { add() };
        Button(panel)
                .setCaption("Substract")
                .onClick { substract() };
        Button(panel)
                .setCaption("Multiply")
                .onClick { multiply() };
        Button(panel)
                .setCaption("Divide")
                .onClick { divide() };

        TextBox(panel)
                .bindValueToProperty<String, ControlBuilder>("result");


    }

    fun add(){
        modelObject.add();
    }
    fun substract(){
        modelObject.substract();
    }
    fun multiply(){
        modelObject.multiply();
    }
    fun divide(){
        modelObject.divide();
    }


}