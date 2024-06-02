import 'dart:convert';
import 'dart:io';

import 'package:delivery_flutter_app/src/environment/environment.dart';
import 'package:delivery_flutter_app/src/models/product.dart';
import 'package:delivery_flutter_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductsProvider extends GetConnect {
  String url = Environment.API_URL + 'api/products';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Product>> findByCategory(String idCategory) async {
    Response response = await get(
        '$url/findByCategory/$idCategory',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Product> products = Product.fromJsonList(response.body);

    return products;
  }


  Future<Stream> create(Product product, List<File> images) async {
    Uri uri = Uri.parse('${Environment.API_URL}api/products/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for (int i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)
      ));
    }

    request.fields['product'] = json.encode(product);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}
