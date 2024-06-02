import 'package:delivery_flutter_app/src/models/category.dart';
import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:delivery_flutter_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:delivery_flutter_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_flutter_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_flutter_app/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_flutter_app/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
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
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index){
                        return _cardProduct(snapshot.data![index]);
                    }
                    );
                  }
                  else{
                    return Container();
                  }
                }
            );
          }).toList(),
        )
      ),
    );
  }

Widget _cardProduct(Product product){
    return ListTile(
      title:  Text(product.description ?? ''),
      leading: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1!)
            : AssetImage('assets/img/no-image.png') as ImageProvider,
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: 50),
        placeholder:  AssetImage('assets/img/no-image.png'),
      ),
    );
  }



}
