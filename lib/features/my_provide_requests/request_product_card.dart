import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/order_item_model.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class RequestProductCard extends StatefulWidget{
  RequestProductCard({super.key, required this.product});
  ProductModel product;

  @override
  State<RequestProductCard> createState() => _RequestProductCardState();
}

class _RequestProductCardState extends State<RequestProductCard> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool added = cartController.inCart(widget.product.id);
      CartItemModel? item = cartController.getItem(widget.product.id);
      if (item != null) {
        widget.product = item.product;
      }
      return InkWell(
        onTap: (){
          Get.toNamed(RouteNames.productDetailPage, arguments: {
            'productId': widget.product.id,
          });
        },
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                  child: (widget.product.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover):  Image.network(
                                      widget.product.getThumbPath(),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child,
                                          loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null? loadingProgress.cumulativeBytesLoaded /
                                                  (loadingProgress.expectedTotalBytes ?? 1)
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.product.productCode!,maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                        Text(widget.product.name, style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            maxLines: null
                                        ),
                                        Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(widget.product.getDiscountRate(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: secondaryColor)),
                                              Text(widget.product.getPriceIncludeVat,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: primaryColor)),
                                              (widget.product.getPriceIncludeVat!="")?Image.asset('icons/riyal.png' ,width: 12,): const SizedBox(),
                                            ]
                                        ),
                                        Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(widget.product.getPreDiscountPrice(),
                                                  style: const TextStyle(fontSize: 14,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration.lineThrough,)),
                                            ]
                                        ),
                                        (added)? Row(children: [
                                          (widget.product.isAvailable(item!.quantity.value)==1)?
                                          Text('available'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: successColor)):
                                          Text('available quantity'.tr + widget.product.inventoryBalance.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)),
                                        ])
                                            :const SizedBox(),
                                        Row(children: [
                                          (widget.product.isAvailable((item!=null)?item.quantity.value:1)==-1)?
                                           Text('in available'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)):
                                          const SizedBox()
                                        ]),
                                      ]
                                  )
                              )
                          )
                        ]
                    ),
                    (widget.product.isAvailable(1) == -1)?
                    Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(13),
                                    backgroundColor: lightGrayColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("icons/wait-box.png", width: 30,),
                                    const SizedBox(width: 7,),
                                    Text('waiting provision'.tr, style: const TextStyle(color: grayColor, fontSize: 16),),
                                  ],
                                )
                            )
                          )
                        ]
                    ):
                    Obx(() {
                      bool added = cartController.inCart(widget.product.id);
                      CartItemModel? item = cartController.getItem(widget.product.id);
                      if (added) {
                        return Padding(
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
                                  onTap: () {
                                    cartController.decrementQuantity(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Image.asset((item!.quantity.value <= 1)? 'icons/trash.png': 'icons/minus.png',width: 20),
                                  ),
                                ),
                                Obx(() =>Text(item.quantity.value.toString())),
                                InkWell(
                                  onTap: () {
                                    cartController.incrementQuantity(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Image.asset('icons/plus.png',width: 20)),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!added) {
                                    CartItemModel item = CartItemModel(product: widget.product);
                                    cartController.addItem(item);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(13),
                                    backgroundColor: secondaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
                                    )
                                ),
                                child: Text('buy now'.tr)
                            ),
                          ),
                          const SizedBox(width: 12,),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!added) {
                                    CartItemModel item = CartItemModel(product: widget.product);
                                    cartController.addItem(item);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(13),
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)
                                    )
                                ),
                                child: Text('add to cart'.tr)
                            )
                          )
                        ]
                      );
                    }
                    ),
                    const SizedBox(width: 10)
                  ],
                )
            )
        ),
      );
    });
  }
}