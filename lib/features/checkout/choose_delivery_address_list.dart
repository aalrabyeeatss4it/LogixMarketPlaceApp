import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/delivery_address_controller.dart';
import '../../controllers/order_controller.dart';

class ChooseDeliveryAddressList extends StatefulWidget{
  const ChooseDeliveryAddressList({super.key});

  @override
  State<StatefulWidget> createState() =>_ChooseDeliveryAddressListState();
}

class _ChooseDeliveryAddressListState extends State<ChooseDeliveryAddressList> {
  final DeliveryAddressController addressController = Get.put(DeliveryAddressController());

  final OrderController orderController = Get.find();

  @override
  void initState() {
    super.initState();
    addressController.getAddresses();
  }

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('choose address'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: const Offset(4, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Obx(() {
                                        if (addressController.isLoading.value) {
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        if (addressController.addresses.isEmpty) {
                                          return Center(child: Text("No addresses".tr));
                                        }
                                        return ListView.builder(
                                            controller: addressController.scroll,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(8),
                                            itemCount: addressController.addresses.length+1,
                                            itemBuilder: (BuildContext context, int index) {
                                              if(index < addressController.addresses.length){
                                                return InkWell(
                                                  onTap: () {
                                                    Get.back(result: addressController.addresses[index]);
                                                  },
                                                  child: Obx(() {
                                                    final address = addressController.addresses[index];
                                                    bool isSelected = orderController.deliveryAddressId.value == (address.id ?? 0);
                                                    return Container(
                                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                                      padding: const EdgeInsets.all(12),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(14),
                                                        border: Border.all(
                                                          color: isSelected? primaryColor: Colors.grey.shade300,
                                                          width: 1,
                                                        ),
                                                        boxShadow: isSelected
                                                            ? [
                                                          BoxShadow(
                                                            color: primaryColor.withOpacity(0.15),
                                                            blurRadius: 8,
                                                            spreadRadius: 1,
                                                          )
                                                        ]
                                                            : [],
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          orderController.deliveryAddressId.value = address.id ?? 0;
                                                          Get.back(result: address);
                                                        },
                                                        child: Row(
                                                          children: [

                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    address.fullAddress ?? "",
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),

                                                                  const SizedBox(height: 8),

                                                                  Text(
                                                                    "${'mobile no'.tr}${address.mobileNo}",
                                                                    style: TextStyle(
                                                                      fontSize: 13,
                                                                      color: Colors.grey.shade600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            if (isSelected)
                                                              const Icon(
                                                                Icons.check_circle,
                                                                color: primaryColor,
                                                              ),

                                                            const SizedBox(width: 8),

                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                                );
                                              }
                                              else{
                                                return (addressController.isLoading.value)?
                                                const Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Center(child: CircularProgressIndicator())
                                                ): const SizedBox();
                                              }
                                            }
                                        );
                                      }
                                      )
                                  )
                              ),
                            ]
                        )
                  )
                ]
            )
        )
    );
  }

}