import 'package:delivery_flutter_app/src/models/order.dart';
import 'package:delivery_flutter_app/src/models/response_api.dart';
import 'package:delivery_flutter_app/src/models/user.dart';
import 'package:delivery_flutter_app/src/providers/orders_provider.dart';
import 'package:delivery_flutter_app/src/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class DeliveryOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  DeliveryOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTotal();
  } 
  
  void updateOrder() async {
      ResponseApi responseApi = await ordersProvider.updateToOnTheWay(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        goToOrderMap();
      }
  }

  void goToOrderMap() {
    Get.toNamed('/delivery/orders/map', arguments: {
      'order': order.toJson()
    });
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}