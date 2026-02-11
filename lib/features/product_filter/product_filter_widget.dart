import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/theme/colors.dart';
import '../../controllers/product_filter_controller.dart';

class ProductFilterWidget extends StatelessWidget{
  ProductFilterWidget({super.key, this.onApplyFilters});
  final ProductFilterController controller = Get.put(ProductFilterController());
  final Function? onApplyFilters;
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text('filters'.tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.back(); // closes the bottom sheet
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('product code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.grey)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: controller.productCodeController,
                    decoration: InputDecoration(
                      hintText: 'filter by product code'.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("icons/search.png",height: 10,width: 10,),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('product name'.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.grey)
              ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: controller.productNameController,
                    decoration: InputDecoration(
                      hintText: 'search by product name'.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("icons/search.png",height: 10,width: 10,),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('price'.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: controller.minPriceController,
                              decoration: InputDecoration(
                                hintText: 'min price'.tr,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: controller.maxPriceController,
                              decoration: InputDecoration(
                                hintText: 'max price'.tr,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16),
            //   child: Text("المقاس",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            // ),
            // Obx(() {
            //   if (controller.sizes.isEmpty) return const SizedBox();
            //   return Wrap(
            //     spacing: 8,
            //     children: controller.sizes.map((size) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: ChoiceChip(
            //           label: SizedBox(
            //               width: 30,
            //               height: 30,
            //               child: Center(child: Text(size.name))
            //           ),
            //           selected: size.selected.value,
            //           selectedColor: Colors.blue,
            //           backgroundColor: Colors.grey.shade200,
            //           labelStyle: TextStyle(
            //             color: size.selected.value ? Colors.white : Colors.black,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           onSelected: (isSelected) {
            //             size.selected.value = isSelected;
            //             if (isSelected) {
            //               if (!controller.selectedSizeId.contains(size.id)) {
            //                 controller.selectedSizeId.add(size.id);
            //               }
            //             } else {
            //               controller.selectedSizeId.remove(size.id);
            //             }
            //           },
            //         ),
            //       );
            //     }).toList(),
            //   );
            // }),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16),
            //   child: Text("اللون",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            // ),
            // Obx((){
            //   if(controller.colors.isEmpty) return const SizedBox();
            //   return Wrap(
            //     spacing: 8,
            //     children: controller.colors.map((c){
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: ChoiceChip(
            //           label: Container(
            //             width: 30,
            //             height: 30,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: c.colorValue,
            //               border: c.selected.value
            //                   ? Border.all(color: Colors.black, width: 2)
            //                   : null,
            //             ),
            //           ),
            //           selected: c.selected.value,
            //           selectedColor: Colors.transparent,
            //           backgroundColor: Colors.transparent,
            //           onSelected: (isSelected){
            //             c.selected.value = isSelected;
            //             if(!controller.selectedColorId.contains(c.id)){
            //               controller.selectedColorId.add(c.id);
            //             }
            //             else{
            //               controller.selectedColorId.remove(c.id);
            //             }
            //           },
            //         ),
            //       );
            //
            //     }).toList(),
            //   );
            // }),
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
                              controller.resetFilters();
                              if(onApplyFilters != null) onApplyFilters!();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('reset'.tr,style: TextStyle(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 18,),)
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
                              if(onApplyFilters != null) onApplyFilters!();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("filters".tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
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