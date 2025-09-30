import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../../common/theme/colors.dart';

class CategoryProductCard extends StatelessWidget {
  const CategoryProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( width: 120, height: 120, child: Card(child: Image.asset(product.productThumbPath,fit: BoxFit.contain))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.productName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700), softWrap: true,
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
                          Text('- 12% ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: secondaryColor)),
                          Text('126.50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  primaryColor)),
                          Image.asset('icons/riyal.png' ,width: 12,),
                        ]
                    ),
                    const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('500'+'ريال', style: TextStyle(fontSize: 14,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
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
          ],
        ),
      ),
    );
  }
}
