import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../controllers/category_controller.dart';
import 'category_card.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Obx(() {
          if (categoryController.list.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 2 items per row
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.8,
              ),
              itemCount: categoryController.list.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(category: categoryController.list[index]);
              });
        }
        ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 1,),
    );
  }
}
