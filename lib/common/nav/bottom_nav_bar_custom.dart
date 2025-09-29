import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';

import 'bottom_nav_controller.dart';

class BottomNavBarCustom extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  BottomNavBarCustom({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: navController.changeTap,
          items: barItems,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  final List<BottomNavigationBarItem> barItems = [
    BottomNavigationBarItem(label: "الرئيسية",icon: Image.asset('icons/home.png',width: 28),activeIcon: Image.asset('icons/home-active.png',width: 28)),
    BottomNavigationBarItem(label: "التصنيفات",icon: Image.asset('icons/cats.png',width: 28),activeIcon: Image.asset('icons/cats-active.png',width: 28)),
    BottomNavigationBarItem(label: "السلة",icon: Image.asset('icons/cart.png',width: 28),activeIcon: Image.asset('icons/cart-active.png',width: 28)),
    BottomNavigationBarItem(label: "حسابي",icon: Image.asset('icons/profile.png',width: 28),activeIcon: Image.asset('icons/profile-active.png',width: 28)),
  ];
}
