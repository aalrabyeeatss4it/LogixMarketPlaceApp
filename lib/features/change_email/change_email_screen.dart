import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';

class ChangeEmailScreen   extends StatelessWidget{
  final box = GetStorage();

  ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("تغيير البريد الإلكتروني", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                    ],
                  ),
                ),
                const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                    child: Text("البريد الالكتروني الجديد",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'ادخل البريد الالكتروني الجديد..',
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
                    child: Text("أعد البريد الالكتروني الجديد",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'أعد البريد الالكتروني الجديد..',
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
                    child: Text("كلمة المرور الحالية",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'ادخل كلمة المرور الحالية ..',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
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
                          // loginController.logout();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("تغيير البريد الإلكتروني",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                          ],
                        )
                    ),
                  ),
                )
              ]
          )
      ),
    );
  }
}
