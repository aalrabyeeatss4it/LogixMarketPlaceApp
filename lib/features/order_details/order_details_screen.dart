import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../models/order_model.dart';
import '../order_tracking/order_status_card.dart';
import '../orders/order_product_card.dart';
import 'order_detail_product_card.dart';
import 'order_summary_card.dart';

class OrderDetailsScreen extends StatelessWidget{
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderModel;

    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Form(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("تفاصيل الطلب", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                      Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Text('رقم الطلب:',style: TextStyle(fontSize: 18,color: Colors.grey),),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(order.orderId??"",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0,top: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const SizedBox(width: 5,),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: grayBorderColor1.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                                                child: Text(order.orderStatus??"",style: TextStyle(fontSize: 16,color: Colors.black),),
                                              )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(order.deliveryDate??"",style: TextStyle(fontSize: 16,color: Colors.black),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                              )
                          )
                      ),
                      const SizedBox(height: 12,),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
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
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
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
                      OrderSummaryCard(order: order,),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: order.items!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderDetailProductCard(itemModel: order.items![index]);
                          }
                      ),
                    ],
                  ),
                ),
              )
          )
      ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 3),
    );
  }
}
