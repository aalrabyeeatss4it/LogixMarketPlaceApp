import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/storage/local_storage.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class ChangeEmailScreen   extends StatelessWidget{

  ChangeEmailScreen({super.key});
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
                          Text('change email'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                        ],
                      ),
                    ),
                    Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text('new email'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new email';
                          }
                          final regex =  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: infoController.newEmailController,
                        decoration: InputDecoration(
                            hintText: 'fill in new email'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                            )
                        ),
                      ),
                    ),
                    Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text('re fill in new email'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new email confirm';
                          }
                          if (value!=infoController.newEmailController.text) {
                            return 'Email and its confirm must be match.';
                          }
                          return null;
                        },
                        controller: infoController.newEmailConfirmController,
                        decoration: InputDecoration(
                            hintText: 're fill in new email'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                            )
                        ),
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
                  infoController.changeEmail();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('change email'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                ],
              )
          ),
        ),
      ),
    );
  }
}
