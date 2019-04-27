package Model

import org.uqbar.commons.model.annotations.Observable
import java.awt.Color

@Observable
class LoginModel{

    var registeredUser           = String();
    var registeredPass           = String();
    var user                     = String();
    var password                 = String();
    var result: String           = "False";
    var authenticatedColor: Color = Color.ORANGE;

    fun regin(pUser: String, pPassword: String): Unit {

        this.registeredUser    = pUser;
        this.registeredPass    = pPassword;
    }

    fun login(): Unit {
        if (this.registeredUser == this.user &&
            this.registeredPass == this.password){
                this.result = "True"
                this.authenticatedColor = Color.GREEN;
        }else{
                this.result = "False"
                this.authenticatedColor = Color.ORANGE;
        }

    }

}