import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
import 'package:logix_market_place/models/user_password_model.dart';
import 'package:logix_market_place/services/account_info_service.dart';

import '../common/dialogs/bottom_sheets.dart';
import '../services/service_result.dart';

class AccountInfoController extends GetxController {
  final AccountInfoService service = Get.put(AccountInfoService());
  final box = GetStorage();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailConfirmController = TextEditingController();
  final TextEditingController currentPwdController = TextEditingController();
  final TextEditingController  newPwdController = TextEditingController();
  final TextEditingController newPwdConfirmController = TextEditingController();
  RxBool isCurrentPwdHidden = false.obs;
  RxBool isNewPwdHidden = false.obs;
  RxBool isNewPwdConfirmHidden = false.obs;
  void loadData() {
    firstNameController.text = box.read(firstNameIndex);
    lastNameController.text = box.read(lastNameIndex);
    emailController.text = box.read(emailIndex);
  }

  Future<void> changePwd() async {
    UserPasswordModel model = UserPasswordModel();
    model.password = newPwdController.text;
    var serviceResult = await service.changePwd(model);
    if (serviceResult is SuccessStatus) {
      showSuccessBottomSheet(onConfirm: () {  });
    } else if (serviceResult is FailureStatus) {
      showFailureBottomSheet(onConfirm: () {  },errorMessage: serviceResult.errorMessage+model.password!);
      print(serviceResult.errorMessage);
    }
  }
}
