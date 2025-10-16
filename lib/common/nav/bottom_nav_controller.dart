import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> _pages = [
  RouteNames.homePage,
  RouteNames.categoriesPage,
  RouteNames.cartPage,
  RouteNames.orderTrackingPage,
  ];
  void changeTap(int index) {
    // if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    Get.offAllNamed(_pages[index],predicate: (route) => route.isFirst);
  }
}
