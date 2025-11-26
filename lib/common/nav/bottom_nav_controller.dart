import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/controllers/login_controller.dart';

import '../storage/local_storage.dart';


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> _pages = [
    (checkLoggedIn())? RouteNames.homePage: RouteNames.guestHomePage,
    RouteNames.categoriesPage,
    RouteNames.cartPage,
    RouteNames.profilePage,
  ];
  void changeTap(int index) {
    // if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    Get.offAllNamed(_pages[index]);
  }
}
