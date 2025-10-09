import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../models/cart_item_model.dart';

class CategoryProductCard extends StatelessWidget {
  CategoryProductCard({super.key, required this.product});
  final ProductModel product;
  final CartController cartController = Get.find<CartController>();
  final FavController favController = Get.find<FavController>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 120,
                height: 120,
                child: Card(
                    child: Image.network(
                        product.getThumbPath(),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              )
                          );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // return default image if network image fails
                      return Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      );
                    }
                    )
                )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700), softWrap: true,
                      overflow: TextOverflow.visible,
                      maxLines: null
                    ),
                    const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('الخيارات:'),
                          SizedBox(width: 5),
                          Text('2 مقاسات', style: TextStyle(fontSize: 16,color: primaryColor)),
                        ]
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(product.discountPercentage.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                          Text(product.price.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                          Image.asset('icons/riyal.png' ,width: 12,),
                        ]
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(product.preDiscountPrice.toString()+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Obx(() {
                          bool added = cartController.inCart(product.id);
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
                          child: Obx(() {
                            bool added = favController.inFav(product.id);
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
          ]
        )
      )
    );
  }
}
