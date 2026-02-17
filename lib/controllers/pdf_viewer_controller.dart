import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class PdfViewerController extends GetxController {
  RxBool isLoading = true.obs;
  // Rx<File?> pdfFile = Rx<File?>(null);
  Rx<Uint8List?> fileBytes = Rx<Uint8List?>(null);

  Future<void> loadPdf(String url) async {
    try {
      // final dir = await getApplicationDocumentsDirectory();
      // final file = File('${dir.path}/temp.pdf');
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fileBytes.value = response.bodyBytes;
        print("loadPdf.success");
        // await file.writeAsBytes(fileBytes);
        // pdfFile.value = file;
      } else {
        Get.snackbar("Error", "Failed to load PDF");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print("Error:"+e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
