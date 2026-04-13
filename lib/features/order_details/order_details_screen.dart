import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/delivery_address_controller.dart';
import '../../controllers/token_controller.dart';
import '../../models/order_model.dart';
import 'order_detail_product_card.dart';
import 'order_summary_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState()=> OrderDetailsScreenState();

}
class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TokenController tokenController = Get.put(TokenController());
  @override
  void initState() {
    super.initState();
    tokenController.getToken();
  }

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderModel;

    double myWidth = MediaQuery.of(context).size.width;
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('order detail'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                      Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: Text('order no'.tr,style: const TextStyle(fontSize: 16,color: Colors.grey),),
                                              ),
                                              const SizedBox(width: 5,),
                                              Text(order.orderCode??"",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
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
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                                                child: Text(order.orderStatus??"",style: const TextStyle(fontSize: 14,color: Colors.black),),
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(order.deliveryDate??"",style: const TextStyle(fontSize: 14,color: Colors.black),),
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
                        shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Text('deliver to'.tr,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w900)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Text(order.shipmentInfo!.deliveryAddress?.fullAddress??"",
                                        style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 0.5),borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('delivery method'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                                  SizedBox(
                                      height: 50,
                                      width: 190,
                                      child:
                                      Center(
                                          child: Row(
                                            children: [
                                              Image.asset("icons/shipment${order.shipmentInfo!.methodId}.png", width: 20,color: Colors.black,),
                                              SizedBox(width: 8),
                                              Text(order.shipmentInfo!.getName??"",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                                              ),
                                            ],
                                          )
                                      )
                                  ),
                                ],
                              ),
                            ),
                            if(order.shipmentInfo?.methodId==2)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 12,left: 12),
                                          child: Image.asset("icons/calender.png", width: 18,color: highlightColor,),
                                        ),
                                        Text('expected delivery date'.tr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: highlightColor))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 40),
                                      child: Text(order.shipmentInfo?.deliveryDate??"", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    )
                                  ],
                                ),
                              ),
                            if(order.shipmentInfo !=null && order.shipmentInfo?.companyId !=0 )
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('shipment company'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                                  Center(
                                    child: SizedBox(
                                      height: 50,
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: (order.shipmentInfo !=null && order.shipmentInfo!.getIconPath().isNotEmpty)?
                                          CachedNetworkImage(
                                            cacheKey: "shipmentId-"+order.shipmentInfo!.companyId.toString(),
                                            imageUrl: order.shipmentInfo!.getIconPath(),
                                            httpHeaders: {
                                              "token": tokenController.ssoToken.value
                                            },
                                            fit: BoxFit.contain,
                                            memCacheWidth: (myWidth * MediaQuery.of(context).devicePixelRatio).toInt(),
                                            maxWidthDiskCache: 1200,
                                            fadeInDuration: const Duration(milliseconds: 200),
                                            fadeOutDuration: const Duration(milliseconds: 200),
                                            placeholder: (_, __) => Text(order.shipmentInfo!.companyName?? ""),
                                            errorWidget: (_, __, ___) => Text(order.shipmentInfo!.companyName?? ""),
                                          )
                                              :Text(order.shipmentInfo!.companyName?? ""),
                                          // )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //       child: Text('tracking no'.tr,style: const TextStyle(fontSize: 16,color: Colors.grey)),
                            //     ),
                            //     const Padding(
                            //       padding: EdgeInsets.symmetric(horizontal: 18.0),
                            //       child: Text('************',style: TextStyle(fontSize: 16,color: Colors.grey)),
                            //     ),
                            //   ],
                            // )
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
                            if(order.items![index].productId==order.shipmentInfo?.feeProductId){
                              return const SizedBox();
                            }
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
