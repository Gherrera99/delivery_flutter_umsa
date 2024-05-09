// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack( // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO
        children: [
          _backgroundCover(context),
          Column( // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO
            children: [
              _imageCover(),
              _textAppName()
            ],
          )
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.amber,
    );
  }

  Widget _textAppName(){
    return Text(
      'RABBIT DELIVERY',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    );
  }

  Widget _textDontHaveAccount(){
    return Row( // UBICAR ELEMENTOS UNO A LADO DEL OTRO (HORIZONTAl)
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
        ),
        SizedBox(width: 7),
        Text(
          'Registrate Aquí',
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      ],
    );
  }

//PRIVADO
  Widget _imageCover() {
    return  SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 35, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 200,
          height: 200,
        ), //image_asset
      ),
    ); //Container
  }
}
