import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/dialogs/bottom_sheets.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/opportunity_controller.dart';
import '../../models/product_offer.dart';

class HomeProductCard extends StatelessWidget {
  HomeProductCard({super.key, required this.product});
  ProductModel product;
  final CartController cartController = Get.find<CartController>();
  final OpportunityController opportunityController = Get.put(OpportunityController());
  final FavController favController = Get.find<FavController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool added = cartController.inCart(product.id);
      CartItemModel? item = cartController.getItem(product.id);
      if(item!=null){
        product = item.product;
      }
      return Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.7,color: grayBorderColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed(RouteNames.productDetailPage, arguments: {
                        'productId': product.id,
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(elevation: 0,child: SizedBox(height: 180.h,width: 280.w,
                              child:(product.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover): Image.network(
                                  product.getThumbPath(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child; // image loaded
                                    return const Center(child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/logo.png',fit: BoxFit.cover);
                                  }
                              )
                          ))
                        ]
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      left: 10,
                      child: Row(
                          children: [
                            (added)? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          cartController.incrementQuantity(item!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Image.asset('icons/plus2.png', width: 20,),
                                        ),
                                      ),
                                      Obx(() => Text(item!.quantity.value.toString())),

                                      InkWell(
                                        radius: 22,
                                        onTap: () {
                                          cartController.decrementQuantity(item);
                                        },
                                        child: SizedBox(
                                          width: 36,
                                          height: 20,
                                          child: Center(
                                            child: Image.asset(
                                              (item!.quantity.value <= 1)
                                                  ? 'icons/trash.png'
                                                  : 'icons/minus2.png',
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ):
                            (product.isAvailable(1) != -1)?
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                  onTap: (){
                                    if(!added){
                                      CartItemModel item = CartItemModel(product: product);
                                      cartController.addItem(item);
                                    }
                                  },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Image.asset('icons/plus2.png', width: 20,),
                                ),
                              ),
                            ): InkWell(
                              onTap: (){
                                showActionConfirmBottomSheet(title: 'order confirm msg'.tr, buttonLabel: 'send'.tr, onConfirm: () {
                                  opportunityController.requestToProvide(product);
                                });

                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Text('request to provide'.tr, style: const TextStyle(color: Colors.white),),
                              ),
                            ),
                          ]
                      )
                  ),
                  Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Obx((){
                          bool added = favController.inFav(product.id);
                          return InkWell(
                            onTap: (){
                              if(added){
                                favController.removeById(product.id);
                              }
                              else{
                                favController.addItem(product);
                              }
                            },
                            child: Image.asset(
                              added ? 'icons/fav-active.png' : 'icons/fav-inactive.png',
                              width: 22,
                              color: added ? primaryColor : Colors.black,
                            ),
                          );
                        }
                        ),
                      )
                  )
                ],
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(RouteNames.productDetailPage, arguments: {
                    'productId': product.id,
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 280.w,child: Text(product.productCode!,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
                    SizedBox(width: 280.w,child: Text(product.getName,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
                    Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(product.getDiscountRate(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                            Text(product.getPriceIncludeVat, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                            (product.getPriceIncludeVat!="")?Image.asset('icons/riyal.png' ,width: 12,): const SizedBox(),
                          ]
                        ),
                    Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(product.getPreDiscountPrice(), style: const TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                            ]
                        ),
                    (added)? Row(children: [
                      (product.isAvailable(item!.quantity.value)==1)?
                      Text('available'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: successColor)):
                      Text('available quantity'.tr+product.inventoryBalance.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)),
                    ])
                        :SizedBox(),
                    Row(children: [
                      (product.isAvailable((item!=null)?item.quantity.value:1)==-1)?
                       Text('in available'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)):
                      const SizedBox()
                    ]),
                    (product.offers.isNotEmpty)?

                    SizedBox(
                      width: 280.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: offerFillColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: offerStrokeColor)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("icons/offers.png", width: 25,color: offerColor,),
                                    const SizedBox(width: 10,),
                                    Text('buy more get more'.tr, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: offerColor2), )
                                  ],
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: product.offers.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final offer = product.offers[index];
                                        // return Text("data");
                                        return offerCard(offer);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):const SizedBox()
                  ],
                ),
              ),
              // Row(
              //   children: [
              //       (added)? Padding(
              //           padding: const EdgeInsets.all(4.0),
              //           child: Container(
              //             width: 210.w,
              //             height: 40,
              //             decoration: BoxDecoration(
              //                 border: Border.all(width: 1.5,color: secondaryColor),
              //                 borderRadius: BorderRadius.circular(20)
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 InkWell(
              //                   onTap: (){
              //                     cartController.decrementQuantity(item);
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                     child: Image.asset((item!.quantity.value<=1)?'icons/trash.png':'icons/minus.png', width: 20,),
              //                   ),
              //                 ),
              //                 Obx(() => Text(item.quantity.value.toString())),
              //                 InkWell(
              //                   onTap: (){
              //                     cartController.incrementQuantity(item);
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                     child: Image.asset('icons/plus.png', width: 20,),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //       ):
              //       (product.isAvailable(1) != -1)?
              //       ElevatedButton(
              //           onPressed: (){
              //             if(!added){
              //               CartItemModel item = CartItemModel(product: product);
              //               cartController.addItem(item);
              //             }
              //           },
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor:  primaryColor,
              //               foregroundColor: Colors.white,
              //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              //           ),
              //           child: Text('add to cart'.tr)
              //       ): ElevatedButton(
              //           onPressed: (){
              //             opportunityController.requestToProvide(product);
              //           },
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor:  secondaryColor,
              //               foregroundColor: Colors.white,
              //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              //           ),
              //           child: Text('request to provide'.tr)
              //       ),
              //     const SizedBox(width: 10),
              //     SizedBox(
              //       width: 50,
              //       child: Obx((){
              //         bool added = favController.inFav(product.id);
              //         return ElevatedButton(
              //             onPressed: (){
              //               if(added){
              //                 favController.removeById(product.id);
              //               }
              //               else{
              //                 favController.addItem(product);
              //               }
              //             },
              //             style: ElevatedButton.styleFrom(
              //               padding: const EdgeInsets.all(5),
              //               backgroundColor: secondaryColor,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10)
              //               )
              //             ),
              //             child: Image.asset(added? 'icons/fav-checked.png' : 'icons/fav.png', width: 30,)
              //         );
              //       }
              //       )
              //     )
              //   ]
              // )
            ]
          )
        )
      );
  }
    );
  }

  Widget offerCard(ProductOffer offer){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(offer.getOfferRange(), style: const TextStyle(fontSize: 14, color: offerColor),textDirection: TextDirection.ltr,),
              const SizedBox(width: 5,),
              Text('piece'.tr, style: const TextStyle(fontSize: 14, color: offerColor)),
            ],
          ),
          Row(
            children: [
              Text(offer.getOfferPriceIncludeVat(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: offerColor)),
              const SizedBox(width: 5,),
              Text(offer.getOfferPriceCurrency(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: offerColor)),
            ],
          ),

        ],
      ),
    );
  }
}
