import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';

class ChangeLangScreen   extends StatelessWidget{
  final box = GetStorage();
  ChangeLangScreen({super.key});

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
                      Text("تغيير اللغة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("اللغة العربية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        Radio(value: 1, groupValue: null, onChanged: (val){})
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("اللغة الإنجليزية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        Radio(value: 1, groupValue: null, onChanged: (val){})
                      ],
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
                            Text("حفظ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
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
