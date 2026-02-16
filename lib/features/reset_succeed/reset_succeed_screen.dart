import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class ResetSucceedScreen extends StatelessWidget{
  ResetSucceedScreen({super.key});

  final box = GetStorage();
  final AccountInfoController infoController = Get.put(AccountInfoController());
  final LoginController loginController = Get.find<LoginController>();
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Center(child: Image.asset("icons/reset-done.png",width: 55)),
                            SizedBox(height: 25.h),
                            Center(
                              child: Text('reset done'.tr,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,),textAlign: TextAlign.center,),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('reset done desc'.tr,style: TextStyle(color: blackColor.withOpacity(0.6),fontSize: 18),textAlign: TextAlign.center,),
                              ),
                            ),
                            const SizedBox(height: 5,),
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
                                            Get.toNamed(RouteNames.loginPage);
                                          },
                                          child: Text('go to login'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }

}