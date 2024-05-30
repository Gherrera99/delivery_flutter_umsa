import 'dart:io';
import 'dart:convert';
import 'package:delivery_flutter_app/src/models/user.dart';
import 'package:delivery_flutter_app/src/providers/user_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/response_api.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos...');

      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res){

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson (json.decode(res));

          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data); //DATOS DEL USUARIO EN SESION
            goToHomePage();
            }
          else{
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }
        });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }



  bool isValidForm(
      String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmPassword
      ){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu numero telefonico');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar la confirmacion del password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'los password no coinciden');
      return false;
    }


    if (imageFile == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
      }

      return true;
  }

Future selectImage(ImageSource imageSource) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null){
      imageFile = File(image.path);
      update();
    }
}



  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );

    AlertDialog alertDialog = AlertDialog(
    title: Text('Selecciona una opcion',
      style: TextStyle(
          color: Colors.black
      ),
    ),
        actions: [
        galleryButton,
        cameraButton
      ],
    );
    // ALertDiaLog
    showDialog(context: context, builder: (BuildContext context) {
    return alertDialog;
    });
    }

}

