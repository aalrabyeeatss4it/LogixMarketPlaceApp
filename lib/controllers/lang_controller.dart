import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/localization/localization_controller.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/services/login_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../common/storage/local_storage.dart';
import '../models/authorized_user_model.dart';
import '../models/user_cred_model.dart';
import 'cart_controller.dart';

class LangController extends GetxController {
  RxString selectedLang = "ar".obs;
  LocalizationController localizationController = Get.put(LocalizationController());
  @override
  Future<void> onInit() async {
    super.onInit();
    selectedLang.value = (await localizationController.getLanguage())!;
  }

  changeLang(String code) {
    selectedLang.value = code;
  }

  void save() {
    localizationController.changeLanguage(selectedLang.value);
  }
}
