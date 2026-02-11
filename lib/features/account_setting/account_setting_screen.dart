import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/login_controller.dart';

class AccountSettingScreen extends StatelessWidget{
  final List<SettingOption> options = [
    SettingOption(title: 'account info'.tr, onTap: (){
      Get.toNamed(RouteNames.accountInfoPage);
    }),
    SettingOption(title: 'change email'.tr, onTap: (){
      Get.toNamed(RouteNames.changeEmailPage);
    }),
    SettingOption(title: 'change password'.tr, onTap: (){
      Get.toNamed(RouteNames.changePasswordPage);
    }),
    SettingOption(title: 'language'.tr, onTap: (){
      Get.toNamed(RouteNames.changeLangPage);
    }),
  ];

  final LoginController loginController = Get.find<LoginController>();

  AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('account settings'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15), // shadow color
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () => options[index].onTap(),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              const SizedBox(width: 20,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(options[index].title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                child: Image.asset("icons/arrow.png",color: Colors.black,width: 7,),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          (index<options.length-1)?Divider(color: Colors.grey.withOpacity(0.2),thickness: 1,):SizedBox()
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 30),
                            child: SizedBox(
                              height: 60,
                              child: TextButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor: redColor.withOpacity(0.1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  onPressed: () {
                                    LoginController.logout();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Image.asset('icons/logout.png' ,width: 30,color: redColor,),
                                      ),
                                      Text('logout'.tr,style: const TextStyle(color: redColor,fontWeight: FontWeight.w700,fontSize: 18))
                                    ],
                                  )

                              ),
                            ),
                          ),
                        ]
                    )
                ),
              ),
            )
          ]
      ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 3,),
    );
  }
}

class SettingOption{
  late String title;
  late Function onTap;
  SettingOption({required this.title,required this.onTap,});
}