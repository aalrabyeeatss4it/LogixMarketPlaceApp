import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../controllers/payment_method_controller.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final PaymentMethodController controller = Get.put(PaymentMethodController());
  PaymentMethodsScreen({super.key});

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
                      child: Text('طرق الدفع',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                    ),
                  ],
                ),
                Obx(() {
                  if (controller.methods.isEmpty) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 150),
                            child: Column(
                                children: [
                                  Image.asset('icons/pay-card.png', width: 45,),
                                  Text('empty payment methods'.tr,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                                  TextButton(
                                      onPressed: () {
                                        // Get.toNamed('/secondPage');
                                      },
                                      child: Text(
                                          'add payment method'.tr,
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
                            itemCount: controller.methods.length,
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
