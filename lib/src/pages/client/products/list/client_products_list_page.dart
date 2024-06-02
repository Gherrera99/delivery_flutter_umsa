import 'package:delivery_flutter_app/src/models/category.dart';
import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:delivery_flutter_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:delivery_flutter_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_flutter_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_flutter_app/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_flutter_app/src/utils/custom_animated_bottom_bar.dart';
import 'package:delivery_flutter_app/src/widget/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {

    return Obx(() => DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return FutureBuilder(
                future: con.getProducts(category.id ?? '1'),
                builder: (context, AsyncSnapshot<List<Product>> snapshot){
                  if(snapshot.hasData){

                    if(snapshot.data!.length > 0){
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index){
                            return _cardProduct(snapshot.data![index]);
                          }
                      );
                    }
                    else{
                      return NoDataWidget(text: 'No hay productos disponibles',);
                    }

                  }
                  else{
                    return NoDataWidget(text: 'No hay productos disponibles',);
                  }
                }
            );
          }).toList(),
        )
      ),
    ));
  }

Widget _cardProduct(Product product){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 20, right: 20),
          child: ListTile(
            title:  Text(product.name ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Text(
                    product.description ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),

              ],
            ),
            trailing: Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(12),
                child: FadeInImage(
                  image: product.image1 != null
                      ? NetworkImage(product.image1!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder:  AssetImage('assets/img/no-image.png'),
                ),
              ),
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey[300], indent: 37,endIndent: 37,)
      ],
    );
  }



}
