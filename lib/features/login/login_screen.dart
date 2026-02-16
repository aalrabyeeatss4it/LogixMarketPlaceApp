import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Row(
                        children: [
                          Text("welcome".tr,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
                          Image.asset("icons/hello.png",height: 32,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('fill in your login data'.tr,style: const TextStyle(color: Colors.grey,fontSize: 16),),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('username'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                      ),
                      SizedBox(
                        height: 65.h,
                        child: TextFormField(
                          initialValue: loginController.user.value.username,
                          onChanged: (value) => loginController.user.update((u){
                            u?.username = value;
                          }),
                          decoration: InputDecoration(
                              hintText: 'fill in username'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('password'.tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                      ),
                      Obx(()=> SizedBox(
                          height: 65.h,
                          child: TextFormField(
                            initialValue: loginController.user.value.password,
                            onChanged: (value) => loginController.user.update((u){
                              u?.password = value;
                            }),
                            decoration: InputDecoration(
                                suffixIcon:
                                  IconButton(
                                    icon: Icon((loginController.isPasswordHidden.value)? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      loginController.isPasswordHidden.value = !loginController.isPasswordHidden.value;
                                    },
                                  ),
                                hintText: 'fill in password'.tr,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: grayBorderColor1,width: 0.2),
                                )
                            ),
                            obscureText: loginController.isPasswordHidden.value,
                          ),
                        ),
                      ),
                      Obx(() => InkWell(
                        onTap: (){
                          loginController.rememberMe.value = !loginController.rememberMe.value;
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: loginController.rememberMe.value,
                              activeColor: primaryColor,
                              onChanged: (value) {
                                loginController.rememberMe.value = value ?? false;
                              },
                            ),
                            Text(
                              'remember password'.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(height: 6,),
                      InkWell(
                          child: Text('have you forgot your password'.tr,style: const TextStyle(decoration: TextDecoration.underline,color: primaryAccentColor,fontSize: 16,fontWeight: FontWeight.bold)),
                          onTap: (){
                            Get.toNamed(RouteNames.forgetPasswordPage);
                          }
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
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    onPressed: ()
                                    {
                                      loginController.login();
                                      },
                                    child: Text('login'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))),
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
                              Text('don''t you have account'.tr,style: const TextStyle(decoration: TextDecoration.underline,color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold)),
                              Text('create new account'.tr,style: const TextStyle(decoration: TextDecoration.underline,color: primaryAccentColor,fontSize: 16,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          onTap: (){

                          }
                      ),
                    ]
                ),
              )
          )
        )
    );
  }

}