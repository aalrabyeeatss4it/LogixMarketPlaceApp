import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/features/categories/categories_screen.dart';
import 'package:logix_market_place/features/home/home_screen.dart';
import 'package:logix_market_place/features/profile/profile_screen.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  final List<String> _pages = [
  RouteNames.homePage,
  RouteNames.categoriesPage,
  RouteNames.cartPage,
  RouteNames.favPage,
  ];
  void changeTap(int index) {
    // if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    Get.offAllNamed(_pages[index],predicate: (route) => route.isFirst);
  }
}
