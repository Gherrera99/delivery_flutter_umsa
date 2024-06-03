import 'package:delivery_flutter_app/src/pages/client/address/map/client_address_map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ClientAddressCreateController extends GetxController {

  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();


  void openGoogleMaps(BuildContext context) async{
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false
    );

    print('REF POINT MAP ${refPointMap}');
    refPointController.text = refPointMap['address'];
    // latRefPoint = refPointMap['lat'];
    // lngRefPoint = refPointMap['lng'];
  }
}