import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/opportunity_controller.dart';

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
      return InkWell(
        onTap: (){
          Get.toNamed(RouteNames.productDetailPage, arguments: {
            'productId': product.id,
          });
        },
        child: Card(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      SizedBox(width: 280.w,child: Text(product.productCode!,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
                      SizedBox(width: 280.w,child: Text(product.name,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
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
                        Text('available'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: successColor)):
                        Text('available quantity'.tr+product.inventoryBalance.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)),
                      ])
                          :SizedBox(),
                      Row(children: [
                        (product.isAvailable((item!=null)?item.quantity.value:1)==-1)?
                         Text('in available'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)):
                        const SizedBox()
                      ])

                    ],
                  ),
                ),
                Row(
                  children: [
                      (added)? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 210.w,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5,color: secondaryColor),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    cartController.decrementQuantity(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Image.asset((item!.quantity.value<=1)?'icons/trash.png':'icons/minus.png', width: 20,),
                                  ),
                                ),
                                Obx(() => Text(item.quantity.value.toString())),
                                InkWell(
                                  onTap: (){
                                    cartController.incrementQuantity(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Image.asset('icons/plus.png', width: 20,),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ):
                      (product.isAvailable(1) != -1)?
                      ElevatedButton(
                          onPressed: (){
                            if(!added){
                              CartItemModel item = CartItemModel(product: product);
                              cartController.addItem(item);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:  primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          child: Text('add to cart'.tr)
                      ): ElevatedButton(
                          onPressed: (){
                            opportunityController.requestToProvide(product);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:  secondaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          child: Text('request to provide'.tr)
                      ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: Obx((){
                        bool added = favController.inFav(product.id);
                        return ElevatedButton(
                            onPressed: (){
                              if(added){
                                favController.removeById(product.id);
                              }
                              else{
                                favController.addItem(product);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: Image.asset(added? 'icons/fav-checked.png' : 'icons/fav.png', width: 30,)
                        );
                      }
                      )
                    )
                  ]
                )
              ]
            )
          )
        )
      );
  }
    );
  }
}
