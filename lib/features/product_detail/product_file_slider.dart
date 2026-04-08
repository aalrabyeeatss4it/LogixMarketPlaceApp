import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/token_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
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
  bool _initialized = false;
  final TokenController tokenController = Get.put(TokenController());
  final ProductFileController controller = Get.put(ProductFileController());
  List<VideoPlayerController?> videoControllers = [];
  @override
  void initState() {
    super.initState();
    tokenController.getToken();
    // _initVideoControllers();
  }
  Future<File> downloadVideo(String url) async {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();

    final bytes = await consolidateHttpClientResponseBytes(response);

    final file = File('${Directory.systemTemp.path}/video.mp4');
    await file.writeAsBytes(bytes);

    return file;
  }
  Future<void> _initVideoControllers() async {
    videoControllers.clear();
    for (var file in widget.files!) {
      final url = file.getFilePath(tokenController.ssoToken.value);
      print("INIT VIDEO: $url");
      if (_isVideo(url)) {
        final file = await downloadVideo(url);

        VideoPlayerController controller = VideoPlayerController.file(file);

        controller.initialize().then((_) {
          setState(() {});
          print("VIDEO INITIALIZED: $url");
        }).catchError((e) {
          print("VIDEO INIT ERROR: $url -> $e"); // catch errors
        });

        // Uri uri = Uri.parse(url);
        // VideoPlayerController controller = VideoPlayerController.networkUrl(
        //   uri,
        //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        // );
        videoControllers.add(controller);
      } else {
        videoControllers.add(null); // placeholder for images
      }
    }
  }

  bool _isVideo(String url) {
    final ext = url.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'webm'].contains(ext);
  }
  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

      if (!_initialized) {
        _initVideoControllers();
        _initialized = true;
      }
      return  SizedBox(
        width: myWidth,height: myWidth * 3 / 4,
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
                      for (var c in videoControllers) {
                        if (c != null && c.value.isInitialized) {
                          c.pause();
                        }
                      }
                      controller.setCurrentIndex(index);
                    },
                  ),
                  itemCount: fileList.length,
                  itemBuilder: (context, index, realIndex) {
                    final url = fileList[index].getFilePath(tokenController.ssoToken.value);
                    final videoController = videoControllers[index];

                    print("videoController:${videoController != null }");
                    print("videoController isInitialized:${ videoController?.value.isInitialized}");
                    print("videoController:"+url);
                    if (videoController != null && videoController.value.isInitialized) {
                      print("is videoController:");
                      return GestureDetector(
                        onTap: () {
                          if (videoController.value.isPlaying) {
                            videoController.pause();
                          } else {
                            videoController.play();
                          }
                          setState(() {});
                        },
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(videoController),
                              if (!videoController.value.isPlaying)
                                const Icon(Icons.play_circle_outline, size: 60, color: Colors.white70),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  Scaffold(
                                    backgroundColor: Colors.black,
                                    body: Center(
                                      child: PhotoView(
                                        imageProvider: CachedNetworkImageProvider(
                                          url,
                                          headers: {
                                            "token": tokenController.ssoToken.value
                                          },
                                        ),
                                        minScale: PhotoViewComputedScale.contained,
                                        maxScale: PhotoViewComputedScale.covered * 3,
                                        backgroundDecoration: const BoxDecoration(color: Colors.black)),
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
                              placeholder: (_, __) => Image.asset("assets/placeholder_3x1.png",fit: BoxFit.cover),
                              errorWidget: (_, __, ___) => Image.asset("assets/placeholder_3x1.png",fit: BoxFit.cover),
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      );
                    }
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
