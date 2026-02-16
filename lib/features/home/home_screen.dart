import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../controllers/account_statement_controller.dart';
import '../../controllers/category_controller.dart';
import 'announcement_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find<CartController>();
  final AccountStatementController statementController = Get.put(AccountStatementController());

  @override
  void initState() {
    super.initState();
    productController.getRecentlyArrived();
    productController.getMostRequested();
    categoryController.getAll();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await statementController.getBalance();
      statementController.showDebitBottomSheetIfNeeded();
    });
  }


  @override
  Widget build(BuildContext context) {
    return ExitWrapper(
      child:  Scaffold(
        appBar: AppBarCustom(
          title: "home",
          onApplyFilters: (){
            productController.resetPagination();
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
                const AnnouncementSlider(),
                const SizedBox(height: 20),
                SectionTitleCard(title: "categories".tr, showMore: true, showMoreAction: (){
                  Get.offAllNamed(RouteNames.categoriesPage);
                }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() {
                    if (categoryController.isCategoryLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(categoryController.list.isEmpty){
                      return Center(child: Text("No categories".tr));
                    }
                    return SizedBox(
                      height:190.h,
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
                SectionTitleCard(title: "recently added".tr),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Obx(() {
                    if (productController.isLoading.value && productController.page==1) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.recentlyArrivedProducts.isEmpty) {
                      return Center(child: Text("No products".tr));
                    }
                    return SizedBox(
                      height: 390,
                      child: ListView.builder(
                          controller: productController.scroll,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.recentlyArrivedProducts.length+1,
                          itemBuilder: (BuildContext context, int index) {
                            if(index < productController.recentlyArrivedProducts.length){
                              return HomeProductCard(product: productController.recentlyArrivedProducts[index]);
                            }
                            else{
                              return (productController.hasMore && productController.isLoading.value)?
                              const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(child: CircularProgressIndicator())
                              ): const SizedBox();
                            }
                          }
                          ),
                    );
                  }
                  ),
                ),
                SectionTitleCard(title: 'most requested'.tr),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Obx(() {
                    if (productController.isMostRequestedLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.mostRequestedProducts.isEmpty) {
                      return const Center();
                    }
                    return SizedBox(
                      height: 390,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.mostRequestedProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeProductCard(product: productController.mostRequestedProducts[index]);
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
      ),
    );
  }
}
