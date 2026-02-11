import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/controllers/fav_controller.dart';
import 'package:logix_market_place/services/login_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../common/storage/local_storage.dart';
import '../models/authorized_user_model.dart';
import '../models/user_cred_model.dart';
import 'cart_controller.dart';

class LoginController extends GetxController{
  RxBool isLoggedIn = false.obs;
  RxBool rememberMe = false.obs;
  RxBool isPasswordHidden  = true.obs;
  var box = GetStorage();
  LoginService service = Get.put(LoginService());
  Rx<UserCredModel> user = UserCredModel().obs;

  @override
  void onInit(){
    super.onInit();
    if(box.read(rememberMeIndex)==true){
      rememberMe.value = box.read(rememberMeIndex);
      user.value.username = box.read(userNameIndex);
      user.value.password = box.read(pwdIndex);
    }
  }

  Future<void> login() async {
    var serviceResult = await service.login(user.value);
    if(serviceResult is SuccessStatus<AuthorizedUserModel>){
      final userModel = serviceResult.data!;
      box.write(rememberMeIndex, rememberMe.value);
      box.write(tokenIndex, userModel.token);
      box.write(userIdIndex, userModel.userId);
      box.write(userNameIndex, userModel.userName);
      box.write(firstNameIndex, userModel.firstName);
      box.write(lastNameIndex, userModel.lastName);
      box.write(emailIndex, userModel.email);
      box.write(customerIDIndex, userModel.customerID);
      box.write(customerNameIndex, userModel.customerName);
      box.write(customerPhoneIndex, userModel.customerPhone);
      box.write(customerTaxNoIndex, userModel.customerTaxNo);
      box.write(pwdIndex, user.value.password);
      Get.offAllNamed(RouteNames.homePage);
    }
    else if(serviceResult is FailureStatus){
      showFailureBottomSheet(errorMessage: serviceResult.errorMessage,onConfirm: () {  });
    }
  }
  static void logout(){
    var box = GetStorage();
    box.write(tokenIndex, null);
    box.write(userIdIndex, null);
    box.write(firstNameIndex, null);
    box.write(lastNameIndex, null);
    box.write(emailIndex, null);
    if((box.read(rememberMeIndex)??false) ==false){
      box.write(userNameIndex, null);
      box.write(pwdIndex, null);
    }
    Get.offAllNamed(RouteNames.loginPage);
    Get.find<CartController>().clearCart();
    // Get.find<FavController>().clear();
  }
  checkLoggedIn(){
    var token = box.read(tokenIndex);
    isLoggedIn.value = (token!=null);
    return isLoggedIn.value;
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   checkLoggedIn();
  // }

}