import 'package:delivery_flutter_app/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapPage extends StatelessWidget {

  ClientAddressMapController con = Get.put(ClientAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Obx (() => Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Ubica tu punto de referencia en el mapa',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          _iconMyLocation(),
          _cardAddress(),
          _buttonAccept(context),
        ],
      ),
    ));
  }

  Widget _buttonAccept(BuildContext context){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.selectRefPoint(context),
        child: Text('SELECCIONAR ESTE PUNTO',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }


  Widget _cardAddress(){
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            con.addressName.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation(){
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Center(
        child: Image.asset('assets/img/my_location_yellow.png',
          width: 65,
          height: 65,
        ),
      ),
    );
  }


  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.terrain,
      onMapCreated: con.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        con.initialPosition = position;
      },
    onCameraIdle: () async {
    await con.setLocationDraggableInfo(); // EMPEZAR A OBTNER LA LAT Y LNG DE LA POSICION CENTRAL DEL MAPA},
      },
    );
  }
}
