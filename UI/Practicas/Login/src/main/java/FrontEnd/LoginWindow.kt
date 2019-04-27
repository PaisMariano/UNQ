package FrontEnd

import Model.LoginModel
import org.uqbar.arena.widgets.*
import org.uqbar.arena.windows.MainWindow
import org.uqbar.lacar.ui.model.ControlBuilder

public class LoginWindow(lmodel : LoginModel) : MainWindow<LoginModel>(lmodel){

    override fun createContents(panel: Panel) {

        title = "User Login Interface";

        Label(panel)
                .setText("User")
                .alignCenter();
        TextBox(panel)
                .bindValueToProperty<String, ControlBuilder>("user");

        Label(panel)
                .setText("Password")
                .alignCenter();
        PasswordField(panel)
                .bindValueToProperty<String, ControlBuilder>("password");

        Button(panel)
                .setCaption("Autenticate")
                .onClick { log() };
        val status = Label(panel);
        status.bindValueToProperty<String, ControlBuilder>("result")
        status.bindBackgroundToProperty<ControlBuilder, Any, Any>("authenticatedColor");

    }

    private fun log(){
        modelObject.login();
    }
}

