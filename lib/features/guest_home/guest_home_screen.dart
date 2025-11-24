import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/cart_controller.dart';
import 'package:logix_market_place/controllers/product_controller.dart';
import 'package:logix_market_place/features/home/home_category_card.dart';
import 'package:logix_market_place/features/home/home_product_card.dart';
import 'package:logix_market_place/common/widgets/section_title_card.dart';
import '../../common/exit_wrapper.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/category_controller.dart';
import '../home/announcement_slider.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<StatefulWidget> createState()=> GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {

  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    productController.getGuestProducts();
    categoryController.getGuestCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ExitWrapper(
      child:  Scaffold(
        appBar: AppBarCustom(
          title: "home",
          onApplyFilters: (){
            productController.getRecentlyArrived();
            Get.back();
            Get.focusScope?.unfocus();
          }
          ),
        body: SingleChildScrollView(
          child: Card(
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SectionTitleCard(title: "categories".tr, showMore: true, showMoreAction: (){
                  Get.offAllNamed(RouteNames.categoriesPage);
                }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() {
                    if(categoryController.guestCategories.isEmpty){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height:190.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryController.guestCategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeCategoryCard(
                                category: categoryController.guestCategories[index]);
                          }),
                    );
                  }
                  ),
                ),
                SectionTitleCard(title: "recently added".tr),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.guestProducts.isEmpty) {
                      return const Center(child: Text("No products"));
                    }
                    return SizedBox(
                      height: 350,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.guestProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeProductCard(product: productController.guestProducts[index]);
                          }),
                    );
                  }
                  ),
                ),

                // SectionTitleCard(title: 'most requested'.tr),
                // Padding(
                //   padding: EdgeInsets.all(16.w),
                //   child: Obx(() {
                //     if(productController.mostRequestedProducts.isEmpty){
                //       return const Center(child: CircularProgressIndicator());
                //     }
                //     return SizedBox(
                //       height: 350,
                //       child: ListView.builder(
                //           shrinkWrap: true,
                //           scrollDirection: Axis.horizontal,
                //           itemCount: productController.mostRequestedProducts.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             return HomeProductCard(product: productController.mostRequestedProducts[index]);
                //           }),
                //     );
                //   }
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarCustom(),
      ),
    );
  }
}
