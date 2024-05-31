import 'package:delivery_flutter_app/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_flutter_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_flutter_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_flutter_app/src/pages/home/home_page.dart';
import 'package:delivery_flutter_app/src/pages/login/login_page.dart';
import 'package:delivery_flutter_app/src/pages/register/register_page.dart';
import 'package:delivery_flutter_app/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_flutter_app/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:delivery_flutter_app/src/models/user.dart';


User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      title: 'Rabbit Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles' : '/client/products/list' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/restaurant/orders/list', page: () => RestaurantOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
        GetPage(name: '/client/profile/info', page: () => ClientProfileInfoPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
            primary: Colors.amber,
            secondary: Colors.amberAccent,
            brightness: Brightness.light,
            onBackground: Colors.grey,
            onPrimary: Colors.grey,
            surface: Colors.amber,
            onSurface: Colors.red,
            error: Colors.grey,
            onError: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.white
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
