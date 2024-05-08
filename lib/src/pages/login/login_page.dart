import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _imageCover()
        ],
      ),
    );
  }


//PRIVADO
  Widget _imageCover() {
    return  Container(
      child: Image.asset(
        'assets/img/delivery.png',
        width: 130,
        height: 130,
      ), //image_asset
    ); //Container
  }
}
