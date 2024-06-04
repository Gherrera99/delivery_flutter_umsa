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

  ClientAddressListController(){
    print('LA DIRECCION DE SESION ${GetStorage().read('address')}');
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');

    Address a = Address.fromJson(GetStorage().read('address') ?? {}); // DIRECCION SELECCIONADA POR EL USUARIO
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue.value = index;
    }

    return address;
  }

  void handleRadioValueChange(int? value){
    radioValue.value = value!;
    print('VALOR SELECCIONADO');
    GetStorage().write('address', address[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }

}