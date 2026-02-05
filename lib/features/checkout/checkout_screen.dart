import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/delivery_address_controller.dart';
import 'package:logix_market_place/features/checkout/checkout_product_card.dart';

import '../../common/dialogs/bottom_sheets.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../new_address/address_card.dart';
import '../new_address/new_address_form.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<StatefulWidget> createState()=>_CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen>{

  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
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
        body: Form(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      SectionTitleCard(title: 'checkout'.tr),
                      SizedBox(height: 25.h),
                      (addressController.defaultAddress.value !=null )?
                      Obx(()=> Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AddressCard(addressModel: addressController.defaultAddress.value!),
                        ),
                      ):
                      Column(
                        children: [
                          SectionTitleCard(title: 'delivery address'.tr,fontSize: 14,),
                          const NewAddressForm(),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      SectionTitleCard(title: 'payment method'.tr),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                      //   child: Obx(()=>
                      //      Card(
                      //       elevation: 0,
                      //       color: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15),
                      //           side: const BorderSide(color: grayBorderColor1,width: 1)
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Image.asset("icons/apple-pay.png",height: 35,),
                      //                 SizedBox(width: 5),
                      //                 const Text("Apple Pay")
                      //               ],
                      //             ),
                      //             Radio(
                      //                 value: 1,
                      //                 groupValue: orderController.paymentMethod.value,
                      //                 onChanged: (val) {
                      //                   if(val!=null) orderController.paymentMethod.value = val;
                      //                 }
                      //                 )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                        child: Obx(()=>
                          Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(color: grayBorderColor1,width: 1)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("icons/debit.png",height: 35,width: 30,),
                                      const SizedBox(width: 10),
                                      Text('deferred'.tr)
                                    ],
                                  ),
                                  Radio(
                                      value: 2,
                                      groupValue: orderController.paymentMethod.value,
                                      onChanged: (val) {
                                        if(val!=null) orderController.paymentMethod.value = val;
                                      }
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                        child: Row(
                          children: [
                            Image.asset("icons/add-card.png",height: 35,width: 30,),
                            const SizedBox(width: 5),
                            const Text("أضف بطاقة فيزا / ائتمان",
                              style: TextStyle(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                                fontSize: 16
                              )
                            )
                          ],
                        ),
                      ),
                      SectionTitleCard(title: 'delivery method'.tr),
                      Obx(()=>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 120.h,
                                width: 180.w,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: grayBorderColor1,width: 1)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      children:
                                      [
                                        Center(
                                          child: SizedBox(width: 80, height: 80,
                                              child: Card(
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset("icons/aramex.png"),
                                                  )
                                              )
                                          ),
                                        ),
                                        Positioned(
                                            child: Radio(
                                              value: 1,
                                              groupValue: orderController.shipmentMethod.value,
                                              onChanged: (val) {
                                                if(val!=null) orderController.shipmentMethod.value = val;
                                                },
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4)
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120.h,
                                width: 180.w,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: grayBorderColor1,width: 1)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      children:
                                      [
                                        Center(
                                          child: SizedBox(width: 80, height: 80,
                                              child: Card(
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset("icons/smsa.png"),
                                                  )
                                              )
                                          ),
                                        ),
                                        Positioned(
                                            child: Radio(
                                                value: 2,
                                                groupValue: orderController.shipmentMethod.value,
                                                onChanged: (val) {
                                                  if(val!=null) orderController.shipmentMethod.value = val;
                                                },
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4)
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 120.h,
                                width: 180.w,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: grayBorderColor1,width: 1)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      children:
                                      [
                                        Center(
                                          child: SizedBox(width: 80, height: 80,
                                              child: Card(
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset("icons/fedex.png"),
                                                  )
                                              )
                                          ),
                                        ),
                                        Positioned(
                                            child: Radio(
                                                value: 3,
                                                groupValue: orderController.shipmentMethod.value,
                                                onChanged: (val) {
                                                  if(val!=null) orderController.shipmentMethod.value = val;
                                                },
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4)
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 20,),
                      Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: cartController.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckoutProductCard(cartItem: cartController.items[index]);
                          }
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                            child: Text('products'.tr,style: const TextStyle(fontSize: 16)),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: Obx(()=>Text(cartController.subTotal.value.toStringAsFixed(3),style: const TextStyle(fontSize: 16),)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('icons/riyal.png' ,width: 12,),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                            child: Text('vat'.tr,style: const TextStyle(fontSize: 16)),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: Obx(()=>Text(cartController.totalVat.value.toStringAsFixed(3),style: const TextStyle(fontSize: 16),)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('icons/riyal.png' ,width: 12,),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                            child: Text('التسليم والشحن',style: TextStyle(fontSize: 16)),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: Text('0.00',style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('icons/riyal.png' ,width: 12,),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                            child: Text('إجمالي الطلب',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: Obx(()=>Text(cartController.total.value.toStringAsFixed(3),style: const TextStyle(fontSize: 16),)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Image.asset('icons/riyal.png' ,width: 12,),
                              )
                            ],
                          )
                        ],
                      ),

                    ],
                )
            )
        ),
        bottomNavigationBar: BottomNavBarCustom(currentPage: 2,actionRow: Obx((){
          if (cartController.items.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
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
                              if(addressController.defaultAddress.value!.id==null){
                                showFailureBottomSheet(errorMessage: "لم يتم اضافة عنوان توصيل، يجب اضافة عنوان لإكمال الطلب.",onConfirm: () {  });
                                return;
                              }
                              showOrderConfirmBottomSheet(title: 'متابعة بالدفع الآجل؟', buttonLabel: 'تأكيد الطلب' + " ("+cartController.total.value.toStringAsFixed(3)+") ", onConfirm: () {
                                orderController.createOrder(addressController.defaultAddress.value!.id!);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(()=> Text('تأكيد الطلب' + " ("+cartController.total.value.toStringAsFixed(3)+") ",
                                    style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Image.asset('icons/riyal.png' ,width: 16,color: Colors.white,),
                                )
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        }
        ),),
    );
  }
}
