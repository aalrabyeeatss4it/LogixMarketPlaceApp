import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';

class HomeProductCard extends StatelessWidget {
  const HomeProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.offNamed(RouteNames.productDetailPage, arguments: {
          'productId': product.productId,
        });
      },
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SizedBox( width: 120, height: 120, child: Image.asset(product.productThumbPath,fit: BoxFit.fill))),
              SizedBox(width: 180,child: Text(product.productName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('- 12% ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                    const Text('126.50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                    Image.asset('icons/riyal.png' ,width: 12,),
                  ]),
              const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('500'+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                  ]),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: const Text('أضف إلى السلة')
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(5),
                          backgroundColor: secondaryAccentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        child: Image.asset('icons/fav.png', width: 30,)
                    ),
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
