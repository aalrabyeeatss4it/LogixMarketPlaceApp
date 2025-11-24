import 'package:uni_links/uni_links.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../features/product_detail/product_detail_screen.dart';

class DeepLinkService {
  StreamSubscription? _sub;

  void init() {
    _handleInitialLink();
    _handleIncomingLinks();
  }

  void _handleInitialLink() async {
    final initialUri = await getInitialUri();
    if (initialUri != null) {
      handleDeepLink(initialUri);
    }
  }

  void _handleIncomingLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) handleDeepLink(uri);
    }, onError: (err) {
      print("Deep link error: $err");
    });
  }

  void handleDeepLink(Uri uri) {
    if (uri.pathSegments.contains("p")) {
      final productId = uri.pathSegments.last;
      Get.to(() => const ProductDetailScreen(), arguments: {'productId': int.parse(productId)});
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
