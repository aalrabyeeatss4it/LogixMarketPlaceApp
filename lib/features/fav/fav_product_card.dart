import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/models/product_model.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_item_model.dart';

class FavProductCard extends StatelessWidget {
  FavProductCard({super.key, required this.product});
  final ProductModel product;
  final FavController favController = Get.find<FavController>();
  final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
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
            children: [
              Row(
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
                                  product.getThumbPath(),
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
                      )
                    ],
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
                          Text(product.preDiscountPrice.toString()+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                            onPressed: (){
                              favController.removeItem(product);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: const EdgeInsets.all(5),
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
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Obx(()
                      {
                        bool added = cartController.inCart(product.id);
                        return ElevatedButton(
                            onPressed: (){
                              if(!added){
                                CartItemModel item = CartItemModel(product: product);
                                cartController.addItem(item);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                                padding: const EdgeInsets.all(5),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1,color: Colors.grey),
                                    borderRadius: BorderRadius.circular(25)
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(added? 'added to cart'.tr : 'add to cart'.tr  ),
                            )
                        );
                      }
                      )
                    )
                  )
                ]
              )
            ]
          )
        )
      );
  }
}
