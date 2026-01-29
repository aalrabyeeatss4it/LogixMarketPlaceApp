import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/token_controller.dart';
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
    double myWidth = fileList.isNotEmpty?MediaQuery.of(context).size.width:0;
    return SizedBox(
        width: myWidth,
        height: myWidth * 0.45,
        child: Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
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
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorWidget: (context, url, error) => Image.asset("assets/placeholder_3x1.png", fit: BoxFit.cover),
                          placeholder: (context, url) => Image.asset("assets/placeholder_3x1.png", fit: BoxFit.cover),
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
                                return TabPageSelectorIndicator(
                                    backgroundColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                                    borderColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                                    size: 7
                                );
                              }).toList()
                          )
                      )
                  )
              )
            ]
        )
    );
  }
}
