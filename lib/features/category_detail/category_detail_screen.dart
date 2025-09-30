import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../controllers/product_controller.dart';
import '../home/section_title_card.dart';
import 'category_product_card.dart';

class CategoryDetailScreen extends StatelessWidget{
  final ProductController productController = Get.put(ProductController());

  CategoryDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String,dynamic>;
    final categoryId = args['categoryId'];
    final categoryName = args['categoryName'];
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionTitleCard(title: categoryName, fontSize: 20,),
                  Image.asset('icons/filter.png',width: 30,height: 30,)
                ],
              ),
            ),
            Obx(() {
              if (productController.list.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: productController.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryProductCard(product: productController.list[index]);
                  });
            }),
          ],
        ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 1,),
    );
  }
}
