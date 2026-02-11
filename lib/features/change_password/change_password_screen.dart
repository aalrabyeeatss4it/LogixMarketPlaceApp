import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class ChangePasswordScreen   extends StatelessWidget{
  ChangePasswordScreen({super.key});
  final box = GetStorage();
  final AccountInfoController infoController = Get.put(AccountInfoController());
  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('change password'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                        ],
                      ),
                    ),
                    Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text('current password'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a current password';
                            }
                            if (box.read(pwdIndex)!=infoController.currentPwdController.text) {
                              return 'Current password is not correct.';
                            }
                            return null;
                          },
                          controller: infoController.currentPwdController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isCurrentPwdHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isCurrentPwdHidden.value = !infoController.isCurrentPwdHidden.value;
                                },
                              ),
                              hintText: 'fill current password'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isCurrentPwdHidden.value,
                        ),
                      ),
                    ),
                    Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text('new password'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[a-zA-Z0-9])[a-zA-Z0-9!@#$%^&*]{8,}$');
                            if (!regex.hasMatch(value)) {
                              return 'Password must be at least 8 chars, include letters, numbers, and a symbol';
                            }
                            return null;
                          },
                          controller: infoController.newPwdController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isNewPwdHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isNewPwdHidden.value = !infoController.isNewPwdHidden.value;
                                },
                              ),
                              hintText: 'fill in new password'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isNewPwdHidden.value,
                        ),
                      ),
                    ),
                    Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text('re fill in new password'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password confirm';
                            }

                            if (value!=infoController.newPwdController.text) {
                              return 'Password and its confirm not match.';
                            }
                            return null;
                          },
                          controller: infoController.newPwdConfirmController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isNewPwdConfirmHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isNewPwdConfirmHidden.value = !infoController.isNewPwdConfirmHidden.value;
                                },
                              ),
                              hintText: 're fill in new password'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isNewPwdConfirmHidden.value,
                        ),
                      ),
                    ),

                  ]
              )
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 60,
          child: TextButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.all(5),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onPressed: () {
                if(formKey.currentState!.validate()){
                  infoController.changePwd();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('change password'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                ],
              )
          ),
        ),
      ),
    );
  }
}