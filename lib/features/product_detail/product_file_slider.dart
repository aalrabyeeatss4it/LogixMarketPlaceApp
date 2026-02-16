import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/token_controller.dart';
import 'package:photo_view/photo_view.dart';
import '../../controllers/announcement_controller.dart';
import '../../controllers/product_file_controller.dart';
import '../../models/product_image_model.dart';

class ProductFileSlider extends StatefulWidget {
  const ProductFileSlider({super.key, required this.files});
  final List<ProductImageModel>? files;
  @override
  State<StatefulWidget> createState() => _ProductFileSliderState();
}
class _ProductFileSliderState extends State<ProductFileSlider>{

  final TokenController tokenController = Get.put(TokenController());
  final ProductFileController controller = Get.put(ProductFileController());

  @override
  void initState() {
    super.initState();
    tokenController.getToken();
  }

  @override
  Widget build(BuildContext context) {
    print("ProductFileSlider"+widget.files!.length.toString());
    if (widget.files != null && widget.files!.isEmpty) {
      return const Center();
    }
    List<ProductImageModel> fileList = widget.files!;
    double myWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      if (tokenController.ssoToken.value.isEmpty) {
        return SizedBox(
          height: myWidth * 0.45,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      return  SizedBox(
        width: myWidth,
        height: myWidth * 0.45,
        child: Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: fileList.length > 1,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    onPageChanged: (index, reason) {
                      controller.setCurrentIndex(index);
                    },
                  ),
                  itemCount: fileList.length,
                  itemBuilder: (context, index, realIndex) {
                    final url = fileList[index].getFilePath(tokenController.ssoToken.value);
                    print("file.url"+url);
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => Scaffold(
                              backgroundColor: Colors.black,
                              body: Center(
                                child: PhotoView(
                                  imageProvider: CachedNetworkImageProvider(
                                    url,
                                    headers: {"token": tokenController.ssoToken.value},
                                  ),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 3,
                                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                                ),
                              ),
                            ));
                          },
                          child: CachedNetworkImage(
                            cacheKey: fileList[index].id.toString(),
                            imageUrl: url,
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
                        ),
                      ),
                    );
                  }
              ),
              Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: fileList.map((banner) {
                                int index = fileList.indexOf(banner);
                                return Obx(()=>
                                   TabPageSelectorIndicator(
                                      backgroundColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                                      borderColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                                      size: 7
                                  ),
                                );
                              }).toList()
                          )
                      )
                  )
              )
            ]
        )
      );
    });
  }
}
