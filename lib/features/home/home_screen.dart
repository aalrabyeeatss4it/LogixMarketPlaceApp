import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/cart_controller.dart';
import 'package:logix_market_place/controllers/product_controller.dart';
import 'package:logix_market_place/features/home/home_category_card.dart';
import 'package:logix_market_place/features/home/home_product_card.dart';
import 'package:logix_market_place/common/widgets/section_title_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/category_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    productController.getRecentlyArrived();
    categoryController.getAll();
  }

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
              SectionTitleCard(title: "categories".tr, showMore: true, showMoreAction: (){
                Get.offAllNamed(RouteNames.categoriesPage);
              },),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() {
                  if(categoryController.list.isEmpty){
                    return const Center(child: CircularProgressIndicator());
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
