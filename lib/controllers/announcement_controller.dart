import 'package:get/get.dart';
import 'package:logix_market_place/models/announcement_model.dart';
import '../services/announcement_service.dart';

class AnnouncementController extends GetxController {
  RxList<AnnouncementModel> list = <AnnouncementModel>[].obs;
  AnnouncementService service = Get.put(AnnouncementService());

  RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    list = <AnnouncementModel>[].obs;
    getAll();
  }

  @override
  void onReady() {
    super.onReady();
    getAll();
  }

  Future<void> getAll() async {
    list.value = await service.getAll();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
