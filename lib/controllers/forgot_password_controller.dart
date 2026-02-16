import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
import 'package:logix_market_place/models/user_password_model.dart';
import 'package:logix_market_place/services/account_info_service.dart';

import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../services/reset_password_service.dart';
import '../services/service_result.dart';

class ForgotPasswordController extends GetxController {
  final ResetPasswordService service = Get.put(ResetPasswordService());
  var isLoading = false.obs;
  RxBool isEmailValid = false.obs;
  RxString emailValidError = "".obs;
  String userId = "59";
  String userName = "test@gmail.com";

  final box = GetStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController  newPwdController = TextEditingController();
  final TextEditingController newPwdConfirmController = TextEditingController();
  RxBool isNewPwdHidden = false.obs;
  RxBool isNewPwdConfirmHidden = false.obs;

  void validateEmail(String? email) {
    final regExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (email == null|| !regExp.hasMatch(email)) {
      emailValidError.value =  'Enter a valid email address'.tr;
      isEmailValid.value = false;
    }
    else{
      isEmailValid.value = true;
      emailValidError.value =  '';
    }
  }
  Future<void> sendOtp() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      UserPasswordModel model = UserPasswordModel();
      model.email = emailController.text;
      var serviceResult = await service.sendOtpEmail(model);
      if (serviceResult is SuccessStatus) {
        showSuccessBottomSheet(onConfirm: () {});
      } else if (serviceResult is FailureStatus) {
        Get.toNamed(RouteNames.otpPage);
        // showFailureBottomSheet(onConfirm: () {}, errorMessage: serviceResult.errorMessage);

      }
    } catch (ex) {

      print(ex.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> verifyOTP() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      UserPasswordModel model = UserPasswordModel();
      model.otp = otpController.text;
      model.userId = userId;
      model.userName = userName;
      var serviceResult = await service.verifyOTP(model);
      if (serviceResult is SuccessStatus) {
        Get.toNamed(RouteNames.resetPasswordPage);
      } else if (serviceResult is FailureStatus) {
        // Get.toNamed(RouteNames.resetPasswordPage);
        showFailureBottomSheet(onConfirm: () {}, errorMessage: serviceResult.errorMessage);

      }
    } catch (ex) {

      print(ex.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      UserPasswordModel model = UserPasswordModel();
      model.password = newPwdController.text;
      model.userId = userId;
      var serviceResult = await service.resetPassword(model);
      if (serviceResult is SuccessStatus) {
        Get.toNamed(RouteNames.resetSucceedPage);
      } else if (serviceResult is FailureStatus) {
        showFailureBottomSheet(onConfirm: () {}, errorMessage: serviceResult.errorMessage);

      }
    } catch (ex) {

      print(ex.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
