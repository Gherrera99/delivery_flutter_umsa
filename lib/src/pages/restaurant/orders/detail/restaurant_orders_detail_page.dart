import 'package:delivery_flutter_app/src/widget/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:delivery_flutter_app/src/models/user.dart';
import 'package:delivery_flutter_app/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:delivery_flutter_app/src/utils/relative_time_util.dart';

class RestaurantOrdersDetailPage extends StatelessWidget {

  RestaurantOrdersDetailController con = Get.put(RestaurantOrdersDetailController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: con.order.status == 'PAGADO'
            ? MediaQuery.of(context).size.height * 0.50
            : MediaQuery.of(context).size.height * 0.45,
        // padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            _dataDate(),
            _dataClient(),
            _dataAddress(),
            // _dataDelivery(),
            _totalToPay(context),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Order #${con.order.id}',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: con.order.products!.isNotEmpty
          ? ListView(
        children: con.order.products!.map((Product product) {
          return _cardProduct(product);
        }).toList(),
      )
          : Center(
          child: NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    ));
  }

  Widget _dataClient() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Cliente y Telefono'),
        subtitle: Text('${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}'),
        trailing: Icon(Icons.person),
      ),
    );
  }

  // Widget _dataDelivery() {
  //   return con.order.status != 'PAGADO'
  //       ? Container(
  //     margin: EdgeInsets.symmetric(horizontal: 20),
  //     child: ListTile(
  //       title: Text('Repartidor asignado'),
  //       subtitle: Text('${con.order.delivery?.name ?? ''} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? ''}'),
  //       trailing: Icon(Icons.delivery_dining),
  //     ),
  //   )
  //       : Container();
  // }

  Widget _dataAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Direccion de entrega'),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Fecha del pedido'),
        subtitle: Text('${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        trailing: Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: Row(
        children: [
          _imageProduct(product),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Cantidad: ${product.quantity}',
                style: TextStyle(
                  // fontWeight: FontWeight.bold
                    fontSize: 13
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 50,
      width: 50,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder:  AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        con.order.status == 'PAGADO'
            ? Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'ASIGNAR REPARTIDOR',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black
            ),
          ),
        )
            : Container(),
        con.order.status == 'PAGADO' ? _dropDownDeliveryMen(con.users) : Container(),
        Container(
          margin: EdgeInsets.only(left: con.order.status == 'PAGADO' ? 30 : 37, top: 15),
          child: Row(
            mainAxisAlignment: con.order.status == 'PAGADO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'TOTAL: \$${con.total.value}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
              con.order.status == 'PAGADO'
                  ? Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    onPressed: () => con.updateOrder(),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15)
                    ),
                    child: Text(
                      'DESPACHAR ORDEN',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    )
                ),
              )
                  : Container()
            ],
          ),
        )

      ],
    );
  }

  Widget _dropDownDeliveryMen(List<User> users) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      margin: EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar repartidor',
          style: TextStyle(

              fontSize: 15
          ),
        ),
        items: _dropDownItems(users),
        value: con.idDelivery.value == '' ? null : con.idDelivery.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          con.idDelivery.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<String>> list = [];
    users.forEach((user) {
      list.add(DropdownMenuItem(
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              child: FadeInImage(
                image: user.image != null
                    ? NetworkImage(user.image!)
                    : AssetImage('assets/img/no-image.png') as ImageProvider,
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            SizedBox(width: 15),
            Text(user.name ?? ''),
          ],
        ),
        value: user.id,
      ));
    });

    return list;
  }

}
