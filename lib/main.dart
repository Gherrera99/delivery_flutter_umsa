import 'package:delivery_flutter_app/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    return GetMaterialApp(
      title: 'Rabbit Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage())
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
