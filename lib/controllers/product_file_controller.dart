import 'package:get/get.dart';
import 'package:logix_market_place/models/announcement_model.dart';
import '../services/announcement_service.dart';

class ProductFileController extends GetxController {
  RxInt currentIndex = 0.obs;
  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
