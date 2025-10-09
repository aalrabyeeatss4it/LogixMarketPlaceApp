import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../models/cart_item_model.dart';

class CartProductCard extends StatelessWidget {
  CartProductCard({super.key, required this.cartItem});
  final CartItemModel cartItem;
  final CartController cartController = Get.find<CartController>();
  final FavController favController = Get.find<FavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>  Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.7,color: grayBorderColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      color: cartItem.selected.value ? Colors.grey[200] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  cartItem.selected.value = !cartItem.selected.value;
                  cartController.updateSelectedCount(cartItem.selected.value);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children:
                      [
                        SizedBox( width: 150, height: 160,
                            child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    cartItem.product.getThumbPath(),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child; // image loaded
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      // return default image if network image fails
                                      return Image.asset(
                                        'assets/logo.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                )
                            )
                        ),
                        Positioned(child: Checkbox(value: cartItem.selected.value, onChanged: (val) {
                          cartItem.selected.value = val?? false;
                          cartController.updateSelectedCount(cartItem.selected.value);
                        },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        ))
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700), softWrap: true,
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
                                  Text(cartItem.product.discountPercentage.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                                  Text(cartItem.product.price.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                                  Image.asset('icons/riyal.png' ,width: 12,),
                                ]
                            ),
                            Text(cartItem.product.preDiscountPrice.toString()+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 210.w,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5,color: secondaryAccentColor),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              cartController.decrementQuantity(cartItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset((cartItem.quantity.value<=1)?'icons/trash.png':'icons/minus.png', width: 20,),
                            ),
                          ),
                          Obx(() => Text(cartItem.quantity.value.toString())),
                          InkWell(
                            onTap: (){
                              cartController.incrementQuantity(cartItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset('icons/plus.png', width: 20,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                        onPressed: (){
                          cartController.removeItem(cartItem);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(5),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1,color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text('حذف'),
                        )
                    ),
                  SizedBox(width: 10),
                  Obx(() {
                    bool added = favController.inFav(cartItem.product.id);
                    return ElevatedButton(
                        onPressed: (){
                          if(!added){
                            favController.addItem(cartItem.product);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            padding: EdgeInsets.all(5),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1,color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text((added)?'في المفضلة':'حفظ لوقت لاحق'),
                        )
                    );}
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
