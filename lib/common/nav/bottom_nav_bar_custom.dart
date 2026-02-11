import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';

import '../../controllers/cart_controller.dart';
import 'bottom_nav_controller.dart';

class BottomNavBarCustom extends StatelessWidget {
  final int currentPage;
  final Widget? actionRow;
  final BottomNavController navController = Get.put(BottomNavController());
  final CartController cartController = Get.find<CartController>();

  BottomNavBarCustom({super.key, this.currentPage = 0, this.actionRow}) {
    // navController.selectedIndex.value = currentPage;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navController.selectedIndex.value = currentPage;
    });

    final List<BottomNavigationBarItem> barItems = [
      BottomNavigationBarItem(label: 'home'.tr,icon: Image.asset('icons/home.png',width: 28),activeIcon: Image.asset('icons/home-active.png',width: 28,color: primaryColor,)),
      BottomNavigationBarItem(label: 'categories'.tr,icon: Image.asset('icons/cats.png',width: 28),activeIcon: Image.asset('icons/cats-active.png',width: 28,color: primaryColor,)),
      BottomNavigationBarItem(
          label: 'cart'.tr,
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('icons/cart.png', width: 28),
              Obx(() {
                final count = cartController.items.length;
                if (count == 0) return const SizedBox.shrink();
                return Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Center(
                      child: Text(
                        count > 99 ? '99+' : '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        activeIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset('icons/cart-active.png', width: 28, color: primaryColor),
            Obx(() {
              final count = cartController.items.length;
              if (count == 0) return const SizedBox.shrink();
              return Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Center(
                    child: Text(
                      count > 99 ? '99+' : '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      BottomNavigationBarItem(label: 'my profile'.tr,icon: Image.asset('icons/profile.png',width: 28),activeIcon: Image.asset('icons/profile-active.png',width: 28,color: primaryColor,)),
    ];
    return Obx(()=> Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        actionRow?? const SizedBox(),
        Theme(
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
      ],
    ),
    );
  }

}
