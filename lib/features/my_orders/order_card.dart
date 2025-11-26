import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../models/order_model.dart';
import 'order_product_card.dart';

class OrderCard extends StatelessWidget{
  final OrderModel order;

  const OrderCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.withOpacity(0.9),width: 0.2),borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0,top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      color: (order.paymentMethodId=="4")?secondaryColor : primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                        child: Text(order.paymentMethod??"",style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                      )
                  ),
                  const SizedBox(width: 5,),
                  Container(
                      decoration: BoxDecoration(
                          color: grayBorderColor1.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset("icons/up-arrow.png",width: 25,),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(order.total?? "",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                            Image.asset('icons/riyal.png' ,width: 14,color: Colors.black,),
                          ]
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Get.toNamed(RouteNames.orderDetailsPage, arguments: order);
                        },
                          child: const Text('تفاصيل الدفع',style: TextStyle(fontSize: 14,color: primaryColor,decoration: TextDecoration.underline))
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: primaryColor)
                              )
                          ),
                          onPressed: () {
                            // Get.offAllNamed(RouteNames.checkoutPage,predicate: (route) => route.isFirst);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('اطلب مجددًا',style: TextStyle(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 16)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: order.items!.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderProductCard(itemModel: order.items![index]);
                }
            ),
          ],
        )
    );
  }

}