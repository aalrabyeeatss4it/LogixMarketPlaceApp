import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/order_item_model.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../models/cart_item_model.dart';

class OrderDetailProductCard extends StatelessWidget{
  const OrderDetailProductCard({super.key, required this.itemModel});
  final OrderItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (itemModel.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover): Image.network(
                                  itemModel.getThumbPath(),
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
                          children: [
                            Text(itemModel.productName??"",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: null
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(itemModel.getPriceIncludeVat,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: primaryColor),),
                                  Image.asset('icons/riyal.png' ,width: 12,color: primaryColor,),
                                ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
      );
  }

}