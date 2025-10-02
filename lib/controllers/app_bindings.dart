import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';

import 'cart_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<CartController>(CartController(), permanent: true);
    Get.put<FavController>(FavController(), permanent: true);
  }

}