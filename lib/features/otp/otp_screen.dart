import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import 'package:pinput/pinput.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/forgot_password_controller.dart';

class OtpScreen extends StatefulWidget{
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState(){
    super.initState();
    controller.otpController.text = "";
  }
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

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
                              Center(child: Image.asset("icons/otp.png",width: 50,)),
                              SizedBox(height: 25.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('fill in otp'.tr,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,),textAlign: TextAlign.center,)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('we sent otp'.tr,style: TextStyle(color: blackColor.withOpacity(0.6),fontSize: 18),textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Pinput(
                                    controller: controller.otpController,
                                    length: 4,
                                    defaultPinTheme: PinTheme(
                                      width: 55,
                                      height: 60,
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onCompleted: (pin) {

                                      print("OTP Entered: $pin");
                                    },
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
                                              if (_formKey.currentState!.validate() && controller.isEmailValid.isTrue) {
                                                controller.verifyOTP();
                                              }
                                            },
                                            child: Text('confirm'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Obx(() => Column(
                              children: [
                              controller.canResend.value
                                  ? TextButton(
                                onPressed: controller.resendOtp,
                                child: Text(
                                  'resend otp'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                                  : Text('resend otp seconds'.tr+"${controller.secondsRemaining.value}"+'second'.tr,
                                          style: TextStyle(color: blackColor.withOpacity(0.6),fontSize: 16,fontWeight: FontWeight.bold),
                                                                  ),

                              ],
                                )
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