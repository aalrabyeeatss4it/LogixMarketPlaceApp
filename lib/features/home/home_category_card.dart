import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../../common/nav/page_routes.dart';
import '../../controllers/token_controller.dart';

class HomeCategoryCard extends StatelessWidget{
   HomeCategoryCard({super.key, required this.category});
  final CategoryModel category;

  final TokenController tokenController = Get.put(TokenController());
  @override
  Widget build(BuildContext context) {

    double myWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (){
        Get.toNamed(RouteNames.categoryDetailPage,
                // (route) => route.settings.name == RouteNames.homePage,
            arguments: {
            'categoryId': category.id,
            'categoryName': category.nameAr
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
                          child: ClipOval(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: (category.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover):
                              CachedNetworkImage(
                                cacheKey: category.id.toString(),
                                imageUrl: category.getThumbPath(),
                                httpHeaders: {
                                  "token": tokenController.ssoToken.value
                                },
                                memCacheWidth: (myWidth * MediaQuery.of(context).devicePixelRatio).toInt(),
                                maxWidthDiskCache: 1200,
                                fadeInDuration: const Duration(milliseconds: 200),
                                fadeOutDuration: const Duration(milliseconds: 200),
                                placeholder: (_, __) => Image.asset("assets/placeholder_3x1.png", fit: BoxFit.cover),
                                errorWidget: (_, __, ___) => Image.asset("assets/placeholder_3x1.png", fit: BoxFit.cover),
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                              // Image.network(
                              //   category.getThumbPath(),
                              //   fit: BoxFit.cover,
                              //   loadingBuilder: (context, child, loadingProgress) {
                              //     if (loadingProgress == null) return child; // image loaded
                              //     return Center(
                              //       child: CircularProgressIndicator(
                              //         value: loadingProgress.expectedTotalBytes != null
                              //             ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              //             : null,
                              //       ),
                              //     );
                              //   },
                              //   errorBuilder: (context, error, stackTrace) {
                              //     // return default image if network image fails
                              //     return Image.asset(
                              //       'assets/logo.png',
                              //       fit: BoxFit.cover,
                              //     );
                              //   },
                              // )
                            ),
                          ),
                        ),
                      ),
                      // Card(
                      //   elevation: 5,
                      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: CircleAvatar(
                      //       radius: 30,
                      //       backgroundImage: AssetImage(category.getThumbPath())
                      //     ),
                      //   ),
                      // )
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      category.nameAr,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

}