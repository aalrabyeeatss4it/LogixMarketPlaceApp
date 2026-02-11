import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/delivery_address_controller.dart';

class DeliveryAddressScreen extends StatefulWidget{
  const DeliveryAddressScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final DeliveryAddressController addressController = Get.put(DeliveryAddressController());

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
                        Text('delivery addresses'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(RouteNames.newAddressPage);
                            },
                            child: Text(
                                'adding new address'.tr,
                                style: const TextStyle(
                                  color: Colors.indigo,
                                  decoration: TextDecoration.underline,
                                )
                            )
                        )
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
                                        if (addressController.isLoading.value && addressController.page==1) {
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
                                                    Get.toNamed(RouteNames.editAddressPage, arguments: addressController.addresses[index]);
                                                  },
                                                  child: Row(
                                                      children: [
                                                        const SizedBox(width: 10,),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(addressController.addresses[index].fullAddress?? "", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                              const SizedBox(height: 10,),
                                                              Text("${'mobile no'.tr}${addressController.addresses[index].mobileNo}",style: const TextStyle(fontSize: 16,color: Colors.grey),)
                                                            ],
                                                          ),
                                                        ),
                                                        Image.asset("icons/arrow.png",color: Colors.black,width: 7,),
                                                        const SizedBox(width: 10,),
                                                      ]
                                                  ),
                                                );
                                              }
                                              else{
                                                return (addressController.hasMore  && addressController.isLoading.value)?
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