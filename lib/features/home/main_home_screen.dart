import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';

import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/bottom_nav_controller.dart';
import '../../common/nav/page_routes.dart';
import '../categories/categories_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class MainHomeScreen extends StatelessWidget {
   MainHomeScreen({super.key});


  final BottomNavController navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: navController.selectedIndex.value,
        children: navController.pages, // each page is a Widget
      )),
      // body: Navigator(
      //   key: Get.nestedKey(1),// optional for nested navigation
      //   onGenerateRoute: (settings) {
      //     Widget page= Container();
      //     switch (settings.name) {
      //       case 'home':
      //         page = HomeScreen();
      //         break;
      //       case '/categories':
      //         page = CategoriesScreen();
      //         break;
      //       case '/cart':
      //         page = CartScreen();
      //         break;
      //       case '/profile':
      //         page = ProfileScreen();
      //         break;
      //       default:
      //         page = HomeScreen();
      //         break;
      //     }
      //     return MaterialPageRoute(builder: (_) => page);
      //   },
      // ),
      bottomNavigationBar: BottomNavBarCustom(),
    );
  }
}
