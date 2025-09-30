import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../../common/nav/page_routes.dart';

class CategoryCard extends StatelessWidget{
  const CategoryCard({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.offNamed(RouteNames.categoryDetailPage, arguments: {
          'categoryId': category.categoryId,
          'categoryName': category.categoryNameAr
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: primaryColor, width: 1),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  category.categoryThumbPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              category.categoryNameAr,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800,color: primaryColor),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

}