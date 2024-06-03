import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapController extends GetxController {

  CameraPosition initialPosition = CameraPosition(
    target: LatLng(20.9690198, -89.6335752),
    zoom: 14
  );

  Completer<GoogleMapController> mapController = Completer();


  void onMapCreate(GoogleMapController controller) {
    controller.setMapStyle('');
    mapController.complete(controller);
  }

}