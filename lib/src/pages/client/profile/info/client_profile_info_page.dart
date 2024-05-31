import 'package:delivery_flutter_app/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack( // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonSignOut()
        ],
      )),
    );
  }


  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonSignOut(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 15, right: 25),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => con.signOut(),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 45,
            ),
          ),
        )
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.goToProfileUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _imageUser(BuildContext context){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top:125),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.user.value.image != null
          ? NetworkImage(con.user.value.image!)
          : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 80,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textName(){
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Text(
        '${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }



  Widget _textEmail(){
    return ListTile(
      leading: Icon(Icons.email),
      title: Text(
        con.user.value.email ?? '',
        style: TextStyle(
            color: Colors.black87
        ),
      ),
      subtitle: Text(
        'Email',
        style: TextStyle(
            color: Colors.black45
        ),
      ),
    );
  }

  Widget _textPhone(){
    return ListTile(
      leading: Icon(Icons.phone),
      title: Text(
        con.user.value.phone ?? '',
        style: TextStyle(
            color: Colors.black87
        ),
      ),
      subtitle: Text(
        'Teléfono',
        style: TextStyle(
            color: Colors.black45
        ),
      ),
    );
  }
}
