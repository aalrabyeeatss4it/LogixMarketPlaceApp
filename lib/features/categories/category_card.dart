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
        Get.toNamed(RouteNames.categoryDetailPage, arguments: {
          'categoryId': category.id,
          'categoryName': category.nameAr
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
                child: (category.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover): Image.network(
                  category.getThumbPath(),
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
              ),
            ),
            Flexible(
              child: Text(
                category.nameAr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2, // no limit
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

}