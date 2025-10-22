import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/services/login_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../common/nav/page_routes.dart';
import '../models/authorized_user_model.dart';
import '../models/user_cred_model.dart';

class LoginController extends GetxController{
  RxBool isLoggedIn = false.obs;
  var box = GetStorage();
  LoginService service = Get.put(LoginService());
  Rx<UserCredModel> user = UserCredModel().obs;

  RxBool isPasswordHidden  = false.obs;
  Future<void> login() async {
    var serviceResult = await service.login(user.value);
    if(serviceResult is SuccessStatus<AuthorizedUserModel>){
      final userModel = serviceResult.data!;
      box.write("token", userModel.token);
      Get.offAllNamed(RouteNames.homePage,predicate: (route) => route.isFirst);
    }
    else{

    }
  }
  void logout(){
    box.write("token", null);
    Get.offAllNamed(RouteNames.loginPage,predicate: (route) => route.isFirst);
  }
  checkLoggedIn(){
    var token = box.read("token");
    isLoggedIn.value = (token!=null);
  }
  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

}