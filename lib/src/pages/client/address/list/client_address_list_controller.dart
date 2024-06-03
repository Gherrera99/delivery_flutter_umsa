import 'package:delivery_flutter_app/src/models/address.dart';
import 'package:delivery_flutter_app/src/models/user.dart';
import 'package:delivery_flutter_app/src/providers/address_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientAddressListController extends GetxController {

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  User user = User.fromJson(GetStorage().read('user'));

  var radioValue = 0.obs;

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    return address;
  }

  void handleRadioValueChange(int? value){
    radioValue.value = value!;
    print('VALOR SELECCIONADO');
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }

}