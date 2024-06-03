import 'package:delivery_flutter_app/src/models/address.dart';
import 'package:delivery_flutter_app/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:delivery_flutter_app/src/widget/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {

  ClientAddressListController con = Get.put(ClientAddressListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Mis Direcciones',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        actions: [
          _iconAddressCreate()
        ],
      ),
      body: Stack(
        children: [
          _textSelectAddress(),
          _listAddress(context),

        ],
      ),
    );
  }

  Widget _listAddress(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: FutureBuilder(
        future: con.getAddress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot){
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemBuilder: (_, index) {
                  return _radioSelectorAddress(snapshot.data![index], index);
                }
              );
            }
            else {
              return Center(
                child: NoDataWidget(text: 'No hay direcciones',),
              );
            }
          }
          else {
            return Center(
              child: NoDataWidget(text: 'No hay direcciones',),
            );
          }
        }
      ),
    );
  }

  Widget _radioSelectorAddress(Address address, int index){
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: con.radioValue.value,
                onChanged: con.handleRadioValueChange,
                activeColor: Colors.lightBlue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    address.neighborhood ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(color: Colors.grey[400],)
        ],
      ),
    ));
  }

  Widget _textSelectAddress() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30),
      child: Text(
        'Elige donde recibir tu pedido',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  
  Widget _iconAddressCreate() {
    return IconButton(
        onPressed: () => con.goToAddressCreate(),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        )
    );
  }
}
