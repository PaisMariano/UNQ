package Model

import FrontEnd.LoginWindow

fun main(){
    var logModel = LoginModel();
    logModel
            .regin("hola","hola")
    LoginWindow(logModel)
            .startApplication();
}
