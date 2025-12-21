import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';

import '../storage/local_storage.dart';


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> _pages = [
    (isLoggedIn())? RouteNames.homePage: RouteNames.guestHomePage,
    RouteNames.categoriesPage,
    RouteNames.cartPage,
    RouteNames.profilePage,
    // RouteNames.googlePayPage,
  ];
  void changeTap(int index) {
    // if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    Get.offAllNamed(_pages[index]);
  }
}
