import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PdfViewerController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<Uint8List?> fileBytes = Rx<Uint8List?>(null);

  Future<void> loadPdf(String url) async {
    print("url:"+url);
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fileBytes.value = response.bodyBytes;
      } else {
        Get.snackbar("Error", "Failed to load PDF");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
