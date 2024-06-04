import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController{

  List<Product> selectedProducts = [];

  void checkIfProductsWasAdded(Product product, var price, var counter) {
    price.value = product.price ?? 0.0;

    if (GetStorage().read('shopping_bag') != null){

      if(GetStorage().read('shopping_bag') is List<Product>){
        selectedProducts = GetStorage().read('shopping_bag');
      }
      else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));

      }

      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if (index != -1) { // EL PRODUCTO YA FUE AGREGADO
        counter.value = selectedProducts[index].quantity ?? 0;
        price.value = product.price! * counter.value;

        selectedProducts.forEach((p) {
          print('Product: ${p.toJson()}');
        });
      }
    }
  }


  //Product product, var price, var counter
  void addToBag(Product product, var price, var counter) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if(counter.value > 0){
        if (index == -1 ) { // NO HA SIDO AGREGADO
          if (product.quantity == null) {
            if (counter.value > 0) {
              product.quantity = counter.value;
            }
            else {
              product.quantity = 1;
            }
          }

          selectedProducts.add(product);
        }
        else { // YA HA SIDOO AGREGADO EN STORAGE
          selectedProducts[index].quantity = counter.value;
        }
        GetStorage().write('shopping_bag', selectedProducts);
        Fluttertoast.showToast(msg: 'Producto agregado');
      }

      else{
        Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
      }


  }

  // Product product, var price, var counter
  void addItem(Product product, var price, var counter) {
    counter.value = counter.value + 1;
    price.value = product.price! * counter.value;
  }
  // Product product, var price, var counter
  void removeItem(Product product, var price, var counter) {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      print('PRODUCTO AGREGADO: ${product.toJson()}');
      price.value = product.price! * counter.value;
    }
  }

}