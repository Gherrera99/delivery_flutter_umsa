import 'dart:io';

import 'package:delivery_flutter_app/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:delivery_flutter_app/src/pages/restaurant/products/restaurant_products_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {

  RestaurantProductsCreateController con = Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context),

        ],
      ),
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
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2, left: 50, right: 50),
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

            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder <RestaurantProductsCreateController>(
                    builder: (value) => _cardimage(context, con.imageFile1, 1),
                  ),
                  SizedBox(width: 5),
                  GetBuilder <RestaurantProductsCreateController>(
                    builder: (value) => _cardimage(context, con.imageFile2, 2),
                  ),
                  SizedBox(width: 5),
                  GetBuilder <RestaurantProductsCreateController>(
                    builder: (value) => _cardimage(context, con.imageFile3, 3),
                  ),

                ],
              ),
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }


  Widget _cardimage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
          onTap: () => con.showAlertDialog(context, numberFile),
          child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.19,
              child: imageFile != null
                  ? Image.file(
                imageFile,
                fit: BoxFit.cover,
              )
                  :Image(
                image: AssetImage('assets/img/cover_image.png'),
              )
          ),
    );
  }



        Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textFieldPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio',
            prefixIcon: Icon(Icons.attach_money)
        ),
      ),
    );
  }

  Widget _textFieldDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.emailAddress,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            prefixIcon: Container(
              margin: EdgeInsets.only(bottom: 70),
                child: Icon(Icons.description)

            )
        ),
      ),
    );
  }




  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
         onPressed: () => con.createCategory(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CREAR PRODUCTO',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textNewCategory(BuildContext context){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top:100),
        alignment: Alignment.topCenter,
        child: Text(
            'NUEVO PRODUCTO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 35,
            )
        ),
      ),
    );
  }

  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA ESTA INFORMACIÓN',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }


}
