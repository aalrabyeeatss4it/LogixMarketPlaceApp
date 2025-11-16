import 'package:get/get.dart';

import '../services/token_service.dart';

class TokenController extends GetxController{
  RxString ssoToken ="".obs;
  TokenService service = Get.put(TokenService());
  Future<void> getToken() async {
    ssoToken.value = await  service.getToken();
  }
}