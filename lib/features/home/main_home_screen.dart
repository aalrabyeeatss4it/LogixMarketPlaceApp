import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/bottom_nav_controller.dart';

class MainHomeScreen extends StatelessWidget {
  MainHomeScreen({super.key});

  final BottomNavController navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
          index: navController.selectedIndex.value,
          children: navController.pages)
      ),
      bottomNavigationBar: BottomNavBarCustom(),
    );
  }
}
