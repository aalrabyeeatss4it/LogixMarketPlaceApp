import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/services/login_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../common/nav/page_routes.dart';
import '../common/storage/local_storage.dart';
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
      box.write(tokenIndex, userModel.token);
      box.write(userIdIndex, userModel.userId);
      box.write(userNameIndex, userModel.userName);
      box.write(firstNameIndex, userModel.firstName);
      box.write(lastNameIndex, userModel.lastName);
      box.write(emailIndex, userModel.email);
      box.write(pwdIndex, user.value.password);
      Get.offAllNamed(RouteNames.homePage,predicate: (route) => route.isFirst);
    }
    else{

    }
  }
  static void logout(){
    var box = GetStorage();
    box.write(tokenIndex, null);
    Get.offAllNamed(RouteNames.loginPage,predicate: (route) => route.isFirst);
  }
  checkLoggedIn(){
    var token = box.read(tokenIndex);
    isLoggedIn.value = (token!=null);
  }
  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

}