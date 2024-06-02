import 'package:delivery_flutter_app/src/providers/categories_provider.dart';
import '../../../../models/category.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ClientProductsListController extends GetxController {

  CategoriesProvider categoriesProvider = CategoriesProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }
}