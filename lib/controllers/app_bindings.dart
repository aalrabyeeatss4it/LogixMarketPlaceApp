import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import 'package:logix_market_place/controllers/product_filter_controller.dart';

import 'cart_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CartController(), permanent: true);
    Get.put(FavController(), permanent: true);
    Get.put(ProductFilterController(), permanent: true);
  }

}