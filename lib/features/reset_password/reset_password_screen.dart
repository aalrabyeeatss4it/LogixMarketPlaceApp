import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';
import '../../controllers/forgot_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget{
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    color: primaryColor.withOpacity(0.05),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              Center(
                                child: Text('reset password'.tr,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,),textAlign: TextAlign.center,),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text('new password desc'.tr,style: TextStyle(color: blackColor.withOpacity(0.6),fontSize: 18),textAlign: TextAlign.center,),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Padding(
                                  padding:  const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                                  child: Text('new password'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                              ),
                              Obx(()=>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                                    child: SizedBox(
                                      height: 90,
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
                                        controller: forgotPasswordController.newPwdController,
                                        decoration: InputDecoration(

                                          labelStyle:TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 16) ,
                                          hintStyle:TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 16) ,
                                          fillColor: Colors.white.withOpacity(0.7),
                                          filled: true,
                                          suffixIcon:
                                            IconButton(
                                              icon: Icon((forgotPasswordController.isNewPwdHidden.value)? Icons.visibility_off : Icons.visibility),
                                              onPressed: () {
                                                forgotPasswordController.isNewPwdHidden.value = !forgotPasswordController.isNewPwdHidden.value;
                                              },
                                            ),
                                          hintText: 'fill in new password'.tr,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: grayBorderColor1.withOpacity(0.9),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: primaryColor, // your focus color
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedErrorBorder:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(color:context.theme.colorScheme.error, width: 0.5),
                                          ) ,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                          ),

                                        ),
                                        obscureText: forgotPasswordController.isNewPwdHidden.value,
                                      ),
                                    ),
                                  ),
                              ),
                              Padding(
                                  padding:  const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                                  child: Text('re fill in new password'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                              ),
                              Obx(()=>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                                    child: SizedBox(
                                      height: 90,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a new password confirm';
                                          }

                                          if (value!=forgotPasswordController.newPwdController.text) {
                                            return 'Password and its confirm not match.';
                                          }
                                          return null;
                                        },
                                        controller: forgotPasswordController.newPwdConfirmController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white.withOpacity(0.7),
                                          filled: true,
                                            suffixIcon:
                                            IconButton(
                                              icon: Icon((forgotPasswordController.isNewPwdConfirmHidden.value)? Icons.visibility_off : Icons.visibility),
                                              onPressed: () {
                                                forgotPasswordController.isNewPwdConfirmHidden.value = !forgotPasswordController.isNewPwdConfirmHidden.value;
                                              },
                                            ),
                                            hintText: 're fill in new password'.tr,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: grayBorderColor1.withOpacity(0.9),
                                              width: 1,
                                            ),
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: primaryColor, // your focus color
                                              width: 1.5,
                                            ),
                                          ),

                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                          ),

                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        obscureText: forgotPasswordController.isNewPwdConfirmHidden.value,
                                      ),
                                    ),
                                  ),
                              ),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: TextButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                padding: const EdgeInsets.all(5),
                                                backgroundColor: primaryColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15)
                                                )
                                            ),
                                            onPressed: ()
                                            {
                                              if (_formKey.currentState!.validate() && forgotPasswordController.isEmailValid.isTrue) {
                                                forgotPasswordController.resetPassword();
                                              }
                                            },
                                            child: Text('save password'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }

}