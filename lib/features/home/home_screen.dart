import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/drawer_custom.dart';
import 'package:logix_market_place/controllers/product_controller.dart';
import 'package:logix_market_place/features/home/home_category_card.dart';
import 'package:logix_market_place/features/home/home_product_card.dart';
import 'package:logix_market_place/features/home/section_title_card.dart';
import 'package:logix_market_place/services/category_service.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/category_controller.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: SingleChildScrollView(
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(width: 1.sw, height: 0.25.sh,child: Image.asset("assets/home.png", fit: BoxFit.contain)),
              ),
              SectionTitleCard(title: "categories".tr, showMore: true),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Obx(() {
                  if(categoryController.list.isEmpty){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    height: 130,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeCategoryCard(
                              category: categoryController.list[index]);
                        }),
                  );
                }
                ),
              ),
              SizedBox(height: 10.h),
              SectionTitleCard(title: "recently added".tr),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Obx(() {
                  if(productController.list.isEmpty){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    height: 350,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeProductCard(product: productController.list[index]);
                        }),
                  );
                }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarCustom(),
    );
  }
}
