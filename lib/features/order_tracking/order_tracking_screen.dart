import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';
import '../../controllers/cart_controller.dart';
import '../checkout/checkout_product_card.dart';
import '../new_address/new_address_form.dart';
import 'order_status_card.dart';

class OrderTrackingScreen extends StatelessWidget{
  final CartController cartController = Get.put(CartController());
  OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Form(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("تتبع الطلب", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                          Text("إلغاء الطلب",
                              style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16
                              )
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const OrderStatusCard(label: 'قيد المعالجة',icon: "icons/preparing.png",isActive: true),
                            Image.asset('icons/order-dots.png',width: 50),
                            const OrderStatusCard(label: 'في طريقه للتسليم',icon: "icons/on-delivery.png",isActive: false),
                            Image.asset('icons/order-dots.png',width: 50),
                            const OrderStatusCard(label: 'تم التسليم',icon: "icons/delivered.png",isActive: false)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text('التوصيل إلى',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Text('شارع 11، فيلا 90،1، 4، حي الياسمين، الرياض 13326، منطقة الرياض، السعودية.',
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Text('تغيير العنوان',style: TextStyle(fontSize: 16,color: primaryColor,decoration: TextDecoration.underline,)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Text('شركة الشحن',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: SizedBox(height: 50,child: Image.asset("icons/aramex.png")
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Text('رقم التتبع:',style: TextStyle(fontSize: 16,color: Colors.grey)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Text('9012 5678 1234',style: TextStyle(fontSize: 16,color: Colors.grey)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Card(
                      elevation: 0,
                      color: primaryColor.withOpacity(0.01),
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('رقم الطلب',style: TextStyle(fontSize: 16)),
                                Text('#258963',style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('السلع',style: TextStyle(fontSize: 16)),
                                Row(
                                  children: [
                                    Text('9,572.00',style: TextStyle(fontSize: 16),),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Image.asset('icons/riyal.png' ,width: 12,),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('التسليم والشحن',style: TextStyle(fontSize: 16)),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                      child: Text('50.00',style: TextStyle(fontSize: 16),),
                                    ),
                                    Image.asset('icons/riyal.png' ,width: 12,)
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('الحالة',style: TextStyle(fontSize: 16),),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  color: primaryColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text('مدفوع',style: TextStyle(fontSize: 16,color: Colors.white),),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('إجمالي الطلب الكلي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                      child: Text('9,622.00',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                                    ),
                                    Image.asset('icons/riyal.png' ,width: 12,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        itemCount: cartController.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckoutProductCard(cartItem: cartController.items[index]);
                        }
                    ),
                    ),
                  ],
                ),
              )
          )
      ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 2,),
    );
  }
}
