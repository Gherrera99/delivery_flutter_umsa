import 'package:delivery_flutter_app/src/models/response_api.dart';
import 'package:delivery_flutter_app/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();



  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email, password)){

      ResponseApi responseApi = await usersProvider.login(email, password);
      
      print('Response Api: ${responseApi.toJson()}');

      if(responseApi.success == true){
        GetStorage().write('user', responseApi.data); //DATOS DEL USUARIO EN SESION
        // goToHomePage();
        goToRolesPage();
      }
      else{
        Get.snackbar('Formulario fallido', responseApi.message ?? '');
      }

    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }



  bool isValidForm(String email, String password){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
}