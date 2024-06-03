import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController {

  List<Product> selectedProducts = <Product>[].obs;
  var total = 0.0.obs;

  ClientOrdersCreateController() {
    if (GetStorage().read('shooping_bag') != null){

      if(GetStorage().read('shooping_bag') is List<Product>){
        var result =  GetStorage().read('shooping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      else{
        var result = Product.fromJsonList(GetStorage().read('shooping_bag'));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      getTotal();
    }
  }

  void getTotal(){
    total.value = 0.0;
    selectedProducts.forEach((product){
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

  void deleteItem(Product product){
    selectedProducts.remove(product);
    GetStorage().write('shooping_bag', selectedProducts);
    getTotal();
  }

  void addItem(Product product){
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts.remove(product);
    product.quantity = product.quantity! + 1;
    selectedProducts.insert(index, product);
    GetStorage().write('shooping_bag', selectedProducts);
    getTotal();
  }

  void removeItem(Product product){
    if(product.quantity! > 1){
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! - 1;
      selectedProducts.insert(index, product);
      GetStorage().write('shopping_bag', selectedProducts);
      getTotal();
    }
  }

}