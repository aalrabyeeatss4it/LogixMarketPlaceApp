import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';

class HomeProductCard extends StatelessWidget {
  HomeProductCard({super.key, required this.product});
  final ProductModel product;
  final CartController cartController = Get.find<CartController>();
  final FavController favController = Get.find<FavController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.offAllNamed(RouteNames.productDetailPage, arguments: {
          'productId': product.productId,
        },predicate: (route) => route.isFirst);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(elevation: 0,child: SizedBox(height: 180.h,width: 280.w, child: Image.asset(product.productThumbPath,fit: BoxFit.contain))),
                ],
              ),
              SizedBox(width: 280.w,child: Text(product.productName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('- 12% ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                    const Text('126.50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                    Image.asset('icons/riyal.png' ,width: 12,),
                  ]),
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('500'+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                  ]),
              Row(
                children: [
                  Obx(() {
                    bool added = cartController.inCart(product.productId);
                    return ElevatedButton(
                        onPressed: (){
                          if(!added){
                            CartItemModel item = CartItemModel(product: product);
                            cartController.addItem(item);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  added? primaryColor.withOpacity(0.5): primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        child: Text(added?'added to cart'.tr : 'add to cart'.tr  )
                    );
                  }
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: Obx((){
                      bool added = favController.inFav(product.productId);
                      return ElevatedButton(
                          onPressed: (){
                            if(added){
                              favController.removeItem(product);
                            }
                            else{
                              favController.addItem(product);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            backgroundColor: secondaryAccentColor,
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
}
