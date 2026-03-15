import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/order_controller.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../models/order_model.dart';
import 'order_product_card.dart';

class OrderCard extends StatelessWidget{
  final OrderModel order;

  const OrderCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 6,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0,top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: (order.paymentMethodId=="4")?secondaryColor : primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                      child: Text(order.paymentMethod??"",style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                    )
                ),
                const SizedBox(width: 5,),
                Container(
                    decoration: BoxDecoration(color: grayBorderColor1.withOpacity(0.3),borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                      child: Text(order.orderStatus??"",style: const TextStyle(fontSize: 16,color: Colors.black),),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(order.deliveryDate??"",style: const TextStyle(fontSize: 16,color: Colors.black),),
                ),
                const Expanded(child: SizedBox()),
                Obx(() => GestureDetector(
                  onTap: () {
                    order.isExpanded.toggle();
                  },
                  child: AnimatedRotation(
                      turns: order.isExpanded.value ? 0 : 0.5,
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset("icons/up-arrow.png",width: 25,color: Colors.black,),
                      )
                  ),
                )),
              ],
            ),
          ),
          Obx(() => AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: order.isExpanded.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('order no'.tr,style: const TextStyle(fontSize: 18,color: Colors.grey),),
                          Text(order.orderCode??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('total'.tr,style: const TextStyle(fontSize: 18,color: Colors.grey),),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(order.total?? "",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900, color: primaryColor),),
                                const SizedBox(width: 5,),
                                Image.asset('icons/riyal.png' ,width: 14,color: primaryColor,),
                              ]
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: order.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderProductCard(itemModel: order.items![index]);
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    elevation: 0,
                                    padding: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(color: primaryColor)
                                    )
                                ),
                                onPressed: () async {
                                  Get.toNamed(RouteNames.orderDetailsPage, arguments: order);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text('order detail'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 50,
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color: primaryColor)
                                  )
                              ),
                              onPressed: () async {
                                await Get.find<OrderController>().orderAgain(order.orderCode!);
                                Get.toNamed(RouteNames.cartPage);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text('order again'.tr,style: const TextStyle(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 16)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            secondChild: const SizedBox.shrink(),
          ),
          ),
        ]
      ),
    );
  }

}