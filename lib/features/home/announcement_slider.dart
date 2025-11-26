import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/token_controller.dart';
import '../../controllers/announcement_controller.dart';

class AnnouncementSlider extends StatefulWidget {
  const AnnouncementSlider({super.key});

  @override
  State<StatefulWidget> createState() => _AnnouncementSliderState();
}
class _AnnouncementSliderState extends State<AnnouncementSlider>{

  final AnnouncementController controller = Get.put(AnnouncementController());
  final TokenController tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    tokenController.getToken();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.list.isEmpty) {
        return const Center();
        return SizedBox(
          height: 150,
          child: Image.asset(
            "assets/placeholder_3x1.png",
            fit: BoxFit.cover,
          ),
        );
      }
      double _width = controller.list.isNotEmpty?MediaQuery.of(context).size.width:0;
      return SizedBox(
        width: _width,
        height: _width * 0.45,
        child: Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    onPageChanged: (index, reason) {
                      controller.setCurrentIndex(index);
                    },
                  ),
                  itemCount: controller.list.length,
                  itemBuilder: (context, index, realIndex) {
                    final url = controller.list[index].getFilePath(tokenController.ssoToken.value);
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.fill,
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
                      children: controller.list.map((banner) {
                        int index = controller.list.indexOf(banner);
                        return TabPageSelectorIndicator(
                            backgroundColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                            borderColor: index == controller.currentIndex.value? primaryColor : Colors.grey,
                            size: 7
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ]),
      );
    });
  }
}
