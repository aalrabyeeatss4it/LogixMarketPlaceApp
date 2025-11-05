import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class AccountInfoScreen  extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<StatefulWidget> createState()=> _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen>{
  final AccountInfoController controller = Get.put(AccountInfoController());

  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("معلومات الحساب", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        Text("تعديل", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,decoration: TextDecoration.underline,color: primaryColor)),
                      ],
                    ),
                  ),
                  const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: Text("البريد الإلكتروني",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                    child: SizedBox(
                      height: 65.h,
                      child: TextFormField(
                        enabled: false,
                        controller: controller.emailController,
                        decoration: InputDecoration(
                            hintText: 'ادخل البريد الإلكتروني..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: Text("الاسم الأول",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                    child: SizedBox(
                      height: 65.h,
                      child: TextFormField(
                        enabled: false,
                        controller: controller.firstNameController,
                        decoration: InputDecoration(
                            hintText: 'ادخل الاسم الأول..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                            )
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: Text("الاسم الأخير",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                    child: SizedBox(
                      height: 65.h,
                      child: TextFormField(
                        enabled: false,
                        controller: controller.lastNameController,
                        decoration: InputDecoration(
                            hintText: 'ادخل الاسم الأخير..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                            )
                        ),
                      ),
                    ),
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
                            // loginController.logout();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("حذف حسابي",style: TextStyle(color: redColor,fontWeight: FontWeight.w700,fontSize: 18))
                            ],
                          )
                      ),
                    ),
                  ),
                ]
            )
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: SizedBox(
      //     height: 60,
      //     child: TextButton(
      //         style: ElevatedButton.styleFrom(
      //             elevation: 0,
      //             padding: const EdgeInsets.all(5),
      //             backgroundColor: primaryColor,
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10)
      //             )
      //         ),
      //         onPressed: () {
      //           // loginController.logout();
      //         },
      //         child: const Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text("حفظ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
      //           ],
      //         )
      //     ),
      //   ),
      // ),
    );
  }
}
