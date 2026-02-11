import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/localization/localization_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/lang_controller.dart';

class ChangeLangScreen   extends StatelessWidget{
  final box = GetStorage();
  ChangeLangScreen({super.key});
  LangController controller = Get.put(LangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('change language'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: (){
                          controller.changeLang("ar");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('arabic'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                            Radio(value: "ar", groupValue: controller.selectedLang.value, onChanged: (val){
                              controller.changeLang(val!);
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: (){
                          controller.changeLang("en");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('english'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                            Radio(value: "en", groupValue: controller.selectedLang.value, onChanged: (val){
                              controller.changeLang(val!);
                            })
                          ],
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
                            controller.save();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('save'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                            ],
                          )
                      ),
                    ),
                  )
                ]
            ),
          )
      ),
    );
  }
}
