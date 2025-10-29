import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../controllers/delivery_address_controller.dart';

class DeliveryAddressScreen extends StatefulWidget{
  DeliveryAddressScreen({super.key});

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
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("عناوين التوصيل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                      ],
                    ),
                  ),
                  Obx(()=>
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
                                      child: InkWell(
                                          onTap: () {
                                          Get.offAllNamed(RouteNames.editAddressPage,predicate: (route) => route.isFirst);
                                          },
                                          child: Column(
                                              children: [
                                                const SizedBox(height: 10,),
                                                Row(
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(addressController.defaultAddress.value?.fullAddress?? "", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            SizedBox(height: 10,),
                                                            Text("رقم الهاتف المتنقل: ${addressController.defaultAddress.value?.mobileNo}",style: const TextStyle(fontSize: 16,color: Colors.grey),)
                                                          ],
                                                        ),
                                                      ),
                                                      Image.asset("icons/arrow.png",color: Colors.black,width: 7,),
                                                      const SizedBox(width: 10,),
                                                    ]
                                                )
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ]
                        )
                    )
                  )
                ]
            )
        )
    );
  }

}