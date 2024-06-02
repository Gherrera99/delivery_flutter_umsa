import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController{

  Product? product;

  var counter = 0.obs;
  var price = 0.0.obs;

  List<Product> selectedProducts = [];

  ClientProductsDetailController(Product product){
    this.product = product;
    price.value = product.price ?? 0.0;

    if (GetStorage().read('shooping_bag') != null){

      if(GetStorage().read('shooping_bag') is List<Product>){
    selectedProducts = GetStorage().read('shooping_bag');
      }
      else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shooping_bag'));

      }

      int index = selectedProducts.indexWhere((p) => p.id == product?.id);
      counter.value = selectedProducts[index].quantity ?? 0;
      price.value = product.price! * counter.value;

      selectedProducts.forEach((p) {
        print('Product: ${p.toJson()}');
      });
    }


  }


  //Product product, var price, var counter
  void addToBag() {
      int index = selectedProducts.indexWhere((p) => p.id == product?.id);

      if(counter.value > 0){
        if (index == -1 ) { // NO HA SIDO AGREGADO
          if (product?.quantity == null) {
            product?.quantity = 1;
          }

          selectedProducts.add(product!);
        }
        else { // YA HA SIDOO AGREGADO EN STORAGE
          selectedProducts[index].quantity = counter.value;
        }
        GetStorage().write('shooping_bag', selectedProducts);
        Fluttertoast.showToast(msg: 'Producto agregado');
      }

      else{
        Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
      }


  }

  // Product product, var price, var counter
  void addItem() {
    counter.value = counter.value + 1;
    price.value = product!.price! * counter.value;
  }
  // Product product, var price, var counter
  void removeItem() {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      price.value = product!.price! * counter.value;
    }
  }

}