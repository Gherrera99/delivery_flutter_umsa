import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/user.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});
}