import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/controllers/cart_controller.dart';
import 'package:logix_market_place/features/cart/cart_product_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';
import '../../controllers/fav_controller.dart';
import '../fav/fav_product_card.dart';

class CartScreen extends StatelessWidget{
    final CartController cartController = Get.put(CartController());
    final FavController favController = Get.put(FavController());

    CartScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Column(
          children: [
            SizedBox(height: 16.h),
            Obx((){
              if (cartController.items.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            if(cartController.selectedItemsCount.value==0){
                              cartController.selectAll();
                            }
                            else{
                              cartController.deSelectAll();
                            }
                          },
                          child: Text((cartController.selectedItemsCount.value==0)? 'تحديد كافة المنتجات':'إلغاء تحديد كافة المنتجات',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w700))),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: cartController.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CartProductCard(cartItem: cartController.items[index]);
                              }
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max
                            ,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                                child: Text('إجمالي الطلب الفرعي',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                    child: Text('9,622.00',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Image.asset('icons/riyal.png' ,width: 12,),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    }),
                    Obx((){
                      if (favController.items.isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        children: [
                          const SizedBox(height: 20,),
                          const Divider(),
                          (favController.items.isNotEmpty)?Row(
                            children: [
                              SectionTitleCard(title: "saved in fav list".tr,fontSize: 16,),
                              SectionTitleCard(title: ' ('+favController.items.length.toString()+' '+'product'.tr+')',fontSize: 14,)
                            ],
                          ):const SizedBox(),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: favController.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FavProductCard(product: favController.items[index]);
                              }
                          ),
                        ],
                      );

                    })
                  ],
                ),
              ),
            ),
            Obx((){
              if (cartController.selectedItemsCount>0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: const EdgeInsets.all(5),
                                    backgroundColor: secondaryAccentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                onPressed: () {
                                  Get.offAllNamed(RouteNames.checkoutPage,predicate: (route) => route.isFirst);
                                },
                                child: const Text('تابع للدفع الآمن',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarCustom(currentPage: 2,),
      );
    }
}
