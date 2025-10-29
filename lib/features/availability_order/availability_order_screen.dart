import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/availability_order_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';

class AvailabilityOrderScreen  extends StatelessWidget {
  final AvailabilityOrderController controller = Get.put(AvailabilityOrderController());
  AvailabilityOrderScreen({super.key});

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
                      child: Text('طلباتي قيد التوفّر',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                    ),
                  ],
                ),
                Obx(() {
                  if (controller.orders.isEmpty) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 150),
                            child: Column(
                                children: [
                                  Image.asset('icons/available-order.png', width: 45,),
                                  Text('empty availability orders'.tr,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                                  TextButton(
                                      onPressed: () {
                                        // Get.toNamed('/secondPage');
                                      },
                                      child: Text(
                                          'browse most requested products'.tr,
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
                            itemCount: controller.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox();
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
