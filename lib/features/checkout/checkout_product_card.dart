import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../models/cart_item_model.dart';

class CheckoutProductCard extends StatelessWidget{

  final CartItemModel cartItem;
  final CartController cartController = Get.find<CartController>();
  final FavController favController = Get.find<FavController>();

  CheckoutProductCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.7,color: grayBorderColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        width: 150,
                        height: 160,
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
                                  return Image.asset(
                                    'assets/logo.png',
                                    fit: BoxFit.cover,
                                  );
                                }
                              )
                            )
                        )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.product.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      maxLines: null
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(cartItem.product.getDiscountRate(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                                        Text(cartItem.product.priceIncludeVat.toStringAsFixed(2), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                                        Image.asset('icons/riyal.png' ,width: 12,),
                                      ]
                                  ),
                                  Text(cartItem.product.getPreDiscountPrice(), style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                                  Row(children: [
                                    (cartItem.product.isAvailable(cartItem.quantity.value)==1)?
                                    Text('متوفر', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: successColor)):
                                    (cartItem.product.isAvailable(cartItem.quantity.value)==-1)?
                                    Text('غير متوفر', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)):
                                    Text('الكمية المتوفرة: '+cartItem.product.inventoryBalance.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)),
                                  ])
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
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
                                  SizedBox(width: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }

}