import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:delivery_flutter_app/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';


class ClientProductsDetailPage extends StatelessWidget {

  Product? product;
  ClientProductsDetailController con = Get.put(ClientProductsDetailController());

  ClientProductsDetailPage({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
          child: _buttonAddToBag()
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            _imageSlideshow(context),
            _textNameProduct(),
            _textDescriptionProduct(),
            _textPriceProduct()

          ],
        ),
      ),
    );
  }

  Widget _buttonAddToBag(){
       return Column(
         children: [
           Divider(height: 1, color: Colors.grey[400]),
           Container(
             margin: EdgeInsets.only(left: 30, right: 28, top: 25),
             child: Row(
               children: [
                 ElevatedButton(
                   onPressed: () {},
                   child: Text('-',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 22,
                     ),
                   ),
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(25),
                             bottomLeft: Radius.circular(25),
                           )
                       )
                   ),
                 ),
                 ElevatedButton(
                   onPressed: () {},
                   child: Text(
                     '0',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 22,
                     ),
                   ),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                     minimumSize: Size(40, 40),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                             topRight: Radius.circular(0),
                             bottomRight: Radius.circular(0),
                             topLeft: Radius.circular(0),
                             bottomLeft: Radius.circular(0),
                           )
                       )
                   ),
                 ),
                 ElevatedButton(
                   onPressed: () {},
                   child: Text('+',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 22,
                     ),
                   ),
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                             topRight: Radius.circular(25),
                             bottomRight: Radius.circular(25),
                           )
                       )
                   ),
                 ),
                 Spacer(),
                 ElevatedButton(
                   onPressed: () {},
                   child: Text(
                     'Agregar   ${product?.price ?? ''}',
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 18,
                     ),
                   ),
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.amber,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25)
                       )
                   ),
                 ),
               ],
             ),
           )

         ],
       );
  }






  Widget _textPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\$${product?.price.toString() ?? ''}',
        style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }


  Widget _textDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black
        ),
      ),
    );
  }

  Widget _imageSlideshow(BuildContext context){
    return SafeArea(
        child: Stack(
          children: [
            ImageSlideshow(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                initialPage: 0,
                indicatorColor: Colors.amber,
                indicatorBackgroundColor: Colors.grey,
                children:[
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 51),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image1 != null
                          ?NetworkImage(product!.image1!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image2 != null
                          ?NetworkImage(product!.image2!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image3 != null
                          ?NetworkImage(product!.image3!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                ]
            )
          ],
        )
    );
  }
}
