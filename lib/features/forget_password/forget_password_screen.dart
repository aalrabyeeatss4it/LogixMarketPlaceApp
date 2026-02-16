import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/forgot_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget{
  ForgetPasswordScreen({super.key});

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
                              Center(child: Image.asset("icons/lock.png",width: 40,)),
                              SizedBox(height: 25.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('forget password'.tr,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,),textAlign: TextAlign.center,)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('fill in email to reset'.tr,style: TextStyle(color: blackColor.withOpacity(0.6),fontSize: 18),textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text('email'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                              ),
                              Obx(()=> SizedBox(
                                  height: 70,
                                  child: TextFormField(
                                    onChanged: (value){
                                      forgotPasswordController.validateEmail(value);
                                    },
                                    cursorColor:context.theme.primaryColor ,
                                    decoration: InputDecoration(
                                      errorText: forgotPasswordController.emailValidError.value,
                                      labelStyle:TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 16) ,
                                      hintStyle:TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 16) ,
                                      fillColor:Colors.white,
                                      filled: true,
                                      isCollapsed: false,
                                      hintText:'fill in email'.tr,
                                      suffixText: '   ',
                                      contentPadding: EdgeInsets.all(6),
                                      prefixIconColor:Get.theme.primaryColor ,
                                      suffixIconColor: Get.theme.indicatorColor,
                                      focusedErrorBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color:context.theme.colorScheme.error, width: 0.5),
                                      ) ,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(width:1.5,color:primaryColor.withOpacity(.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:  BorderSide( color:primaryColor.withOpacity(.2), width: 1),
                                      ),
                                      border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:  BorderSide( color:blackColor, width: 1),
                                      ) ,
                                      errorBorder:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:  BorderSide( color:redColor, width: 1),
                                      ) ,

                                      disabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: blackLightColor, width: 1),
                                      ) ,
                                    ),
                                    style: TextStyle(color: blackColor),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: true,
                                    controller: forgotPasswordController.emailController,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator:(x) {
                                      if(x==null || x=='') {
                                        return "required".tr;
                                      }
                                      return null;
                                    },
                                  )
                                ),
                              ),
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
                                                forgotPasswordController.sendOtp();
                                              }
                                            },
                                            child: Text('send otp'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('back to login'.tr,style: const TextStyle(color: remainingColor,fontSize: 16,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  onTap: (){
                                    Get.toNamed(RouteNames.loginPage);
                                  }
                              ),
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