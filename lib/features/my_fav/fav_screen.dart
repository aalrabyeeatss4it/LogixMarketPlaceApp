import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import 'fav_product_card.dart';

class FavScreen extends StatelessWidget{
final FavController favController = Get.put(FavController());
FavScreen({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarCustom(title: "home"),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,top: 8),
                child: Text('قائمة المفضلة',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
              ),
            ],
          ),
          Obx(() {
            if (favController.items.isEmpty) {
              return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 80),
                    child: Column(
                      children: [
                        Image.asset('icons/empty-fav.png', width: 45,),
                        Text('empty fav'.tr,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                        TextButton(
                          onPressed: () {
                            // Get.toNamed('/secondPage');
                          },
                          child: Text(
                            'Start adding items'.tr,
                            style: const TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            )
                          )
                        )
                      ]
                    )
                  )
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: favController.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FavProductCard(product: favController.items[index]);
                      }),
                ),
              ],
            );
          })
        ]
      )
    ),
    bottomNavigationBar: BottomNavBarCustom(currentPage: 3),
  );
}
}
