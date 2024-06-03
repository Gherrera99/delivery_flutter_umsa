import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController {

  List<Product> selectedProducts = [];
  var counter = 0.obs;

  ClientOrdersCreateController() {
    if (GetStorage().read('shooping_bag') != null){

      if(GetStorage().read('shooping_bag') is List<Product>){
        selectedProducts = GetStorage().read('shooping_bag');
      }
      else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shooping_bag'));

      }
    }
  }
}