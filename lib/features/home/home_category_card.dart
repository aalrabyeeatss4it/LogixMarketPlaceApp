import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../../common/nav/page_routes.dart';

class HomeCategoryCard extends StatelessWidget{
  const HomeCategoryCard({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.offNamedUntil(RouteNames.categoryDetailPage,
                (route) => route.settings.name == RouteNames.homePage,
            arguments: {
            'categoryId': category.categoryId,
            'categoryName': category.categoryNameAr
          });
      },
      child: Card(
          elevation: 0,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(width:80, height: 80,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(category.categoryThumbPath)
                          ),
                        ),
                      )
                  ),
                  Text(category.categoryNameAr,style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          )
      ),
    );
  }

}