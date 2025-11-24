import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/theme/colors.dart';
import '../../controllers/product_filter_controller.dart';

class ProductSortWidget extends StatelessWidget{
  ProductSortWidget({super.key, this.onApplySort});
  final ProductFilterController controller = Get.put(ProductFilterController());
  final Function? onApplySort;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("فرز حسب",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),

            InkWell(
              onTap: (){
                controller.sortBy.value = 1;
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() =>  Radio(value: 1, groupValue: controller.sortBy.value, onChanged: (val){
                          controller.sortBy.value = val  as int;
                        }),
                      ),
                      Text("من الأحدث إلى الأقدم (الأحدث أولًا)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: (){
                controller.sortBy.value = 2;
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() =>  Radio(value: 2, groupValue: controller.sortBy.value, onChanged: (val){
                        controller.sortBy.value = val as int;
                      }),
                      ),
                      Text("من الأقدم إلى الأحدث", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            InkWell(
              onTap: (){
                controller.sortBy.value = 3;
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() =>  Radio(value: 3, groupValue: controller.sortBy.value, onChanged: (val){
                        controller.sortBy.value = val as int;
                      }),
                      ),
                      const Text("من الأعلى سعر إلى الأقل", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            InkWell(
              onTap: (){
                controller.sortBy.value = 4;
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() =>  Radio(value: 4, groupValue: controller.sortBy.value, onChanged: (val){
                        controller.sortBy.value = val as int;
                      }),
                      ),
                      const Text("من الأقل سعر إلى الأعلى", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 60,
                        child: TextButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: const EdgeInsets.all(5),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            onPressed: () {
                              controller.resetSort();
                              if(onApplySort != null) onApplySort!();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("مسح",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 18,),)
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
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
                              if(onApplySort != null) onApplySort!();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("فرز",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

