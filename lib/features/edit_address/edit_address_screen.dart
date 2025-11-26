import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';
import '../../controllers/delivery_address_controller.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditAddressScreenState();

}
class _EditAddressScreenState extends State<EditAddressScreen> {
  final DeliveryAddressController controller = Get.put(DeliveryAddressController());

  @override
  void initState() {
    super.initState();
    controller.getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const SectionTitleCard(title: "تعديل العنوان",fontSize: 22,),
                    const SizedBox(height: 20,),
                    const SectionTitleCard(title: "عنوان التوصيل:",fontSize: 18,),
                    Column(
                        children: [
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: TextFormField(
                                      controller: controller.regionNameController,
                                      decoration: InputDecoration(
                                          hintText: 'المدينة / المنطقة..',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: TextFormField(
                                      controller: controller.districtNameController,
                                      decoration: InputDecoration(
                                          hintText: 'الحي..',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: SizedBox(
                              height: 65.h,
                              child: TextFormField(
                                controller: controller.streetNameController,
                                decoration: InputDecoration(
                                    hintText: 'اسم الشارع..',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                    )
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: TextFormField(
                                      controller: controller.buildingNoController,
                                      decoration: InputDecoration(
                                          hintText: 'رقم الطابق / المبنى/ الشقة / الفيلا..',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: TextFormField(
                                      controller: controller.zipCodeController,
                                      decoration: InputDecoration(
                                          hintText: 'الرمز البريدي..',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: SizedBox(
                              height: 65.h,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'أقرب معلم..',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SectionTitleCard(title: "بيانات شخصية",fontSize: 16,),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: SizedBox(
                              height: 65.h,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'الاسم كامل..',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                    )
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: SizedBox(
                              height: 65.h,
                              child: TextFormField(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.right,
                                controller: controller.mobileNoController,
                                decoration: InputDecoration(
                                    hintText: '+966XXXXXX',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                                    )
                                ),
                              ),
                            ),
                          ),
                          Obx(()=>
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: controller.isDefaultAddress.value,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   isDefaultAddress = value ?? false;
                                      // });
                                    },
                                  ),
                                  const Text("الاستخدام كعناوني الرئيسي."),
                                ],
                              ),
                            ),
                          ),

                        ]
                    )
                  ]
              )
          ),
        ),
      bottomNavigationBar: Padding(
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
                if(formKey.currentState!.validate()){
                  controller.updateAddress();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("تحديث العنوان",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                ],
              )
          ),
        ),
      ),
    );
  }
}