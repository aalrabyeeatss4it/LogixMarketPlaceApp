import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/cart_controller.dart';
import 'package:logix_market_place/features/cart/cart_product_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';

class CartScreen extends StatelessWidget{
    final CartController cartController = Get.put(CartController());
    CartScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Obx(() {
                if (cartController.items.isEmpty) {
                  return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 80),
                        child: Column(
                          children: [
                            Image.asset('icons/empty-cart.png', width: 45,),
                            Text('empty cart'.tr,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                            TextButton(
                              onPressed: () {
                                // Get.toNamed('/secondPage');
                              },
                              child: Text(
                                'Start adding items'.tr,
                                style: const TextStyle(
                                  color: Colors.indigo,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  );
                }
                return Column(
                  children: [
                    (cartController.selectedItemsCount.value==0)?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                cartController.selectAll();
                              },
                              child: const Text('تحديد كافة المنتجات',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w700))),
                        ],
                      ),
                    ):
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                cartController.deSelectAll();
                              },
                              child: const Text('إلغاء تحديد كافة المنتجات',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w700))),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        itemCount: cartController.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartProductCard(cartItem: cartController.items[index]);
                        }),
                  ],
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarCustom(currentPage: 2,),
      );
    }
}
