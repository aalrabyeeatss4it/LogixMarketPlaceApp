import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/controllers/delivery_address_controller.dart';
import 'package:logix_market_place/features/checkout/checkout_product_card.dart';
import '../../common/dialogs/bottom_sheets.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../models/delivery_address_model.dart';
import '../../models/shipment_company_model.dart';
import 'choose_delivery_address_list.dart';

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
    orderController.getAddresses();
    orderController.getShipmentOptions();
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
                      Obx(() {
                        final defaultAddress = orderController.deliveryAddress.value;
                        bool isAddressMissing = defaultAddress == null || defaultAddress.id==null;
                        if(!isAddressMissing){
                          orderController.deliveryAddressId.value = defaultAddress.id!;
                        }
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isAddressMissing ? Colors.red : Colors.transparent,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: isAddressMissing? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderController.addressErrorMessage.value,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SectionTitleCard(
                                title: 'delivery address'.tr,
                                fontSize: 14,
                              ),
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
                          ): addressCard(defaultAddress),
                        );
                      }),
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
                      Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitleCard(title: 'delivery method'.tr),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: orderController.shipmentMethods.length,
                              itemBuilder: (BuildContext context, int index) {
                                var shipmentMethod= orderController.shipmentMethods[index];
                                return Obx(() => shipmentMethodCard(
                                    shipmentMethod.name,
                                    shipmentMethod.code.toString(),
                                    shipmentMethod.code,orderController.shipmentCompanies
                                ),
                                );
                              }
                          ),
                          if (orderController.shipmentMethodErrorMessage.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                orderController.shipmentMethodErrorMessage.value,
                                style: const TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ),
                        ],
                      )),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                            child: Text('delivery'.tr,style: const TextStyle(fontSize: 16)),
                          ),
                          Row(
                            children: [
                              Obx(()=> Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                  child: Text(orderController.deliveryFee.value.totalFee().toStringAsFixed(2), style: const TextStyle(fontSize: 16),),
                                ),
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
                            child: Text('order total'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: Obx(()=>Text((cartController.total.value + orderController.deliveryFee.value.totalFee()).toStringAsFixed(3),style: const TextStyle(fontSize: 16),)),
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
                            onPressed: orderController.isLoading.value? null : () {
                              if (!orderController.validateCheckout()) {
                                return;
                              }
                              showOrderConfirmBottomSheet(title: 'payment proceed'.tr, buttonLabel: "${'order confirm'.tr} (${(cartController.total.value+orderController.deliveryFee.value.totalFee()).toStringAsFixed(3)}) ", onConfirm: () {
                                orderController.createOrder();
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(()=> Text("${'order confirm'.tr} (${(cartController.total.value+orderController.deliveryFee.value.totalFee()).toStringAsFixed(3)}) ",
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

  Widget shipmentCompanyCard(String iconUrl, int myValue, String label){
    print("iconUrl"+iconUrl);
    return InkWell(
      onTap: (){
        orderController.setShipmentCompany(myValue);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(
          width: 165.w,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: (iconUrl.isNotEmpty)? Image.network(
                            iconUrl,
                            width: 28,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child; // image loaded
                              return const Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text(label));
                            }
                        ):Text(label),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Radio<int>(
                    value: myValue,
                    groupValue: orderController.shipmentCompany.value,
                    onChanged: (val) {
                      orderController.setShipmentCompany(myValue);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                    const VisualDensity(horizontal: -2, vertical: -2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shipmentMethodCard(String label, String iconId, int myValue, List<ShipmentCompanyModel> shipmentCompanies){

      bool isSelected = orderController.shipmentMethod.value == myValue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: 1,
            ),
            boxShadow: isSelected? [
              BoxShadow(
                color: Colors.green.withOpacity(0.15),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ]: [],
          ),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  InkWell(
                      onTap: (){
                        orderController.setShipmentMethod(myValue);
                        orderController.setShipmentCompany(0);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Radio(value: myValue, groupValue: orderController.shipmentMethod.value, onChanged: (val){
                                  orderController.setShipmentMethod(myValue);
                                  orderController.setShipmentCompany(0);
                                }),
                                Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                              ],
                            ),
                            Image.asset("icons/shipment$iconId.png", width: 28,)
                          ]
                      )
                  ),
                  if(myValue==2 && orderController.shipmentMethod.value==2)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12,left: 12),
                                child: Image.asset("icons/calender.png", width: 22,color: highlightColor,),
                              ),
                              Text('expected delivery date'.tr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: highlightColor))
                            ],
                          ),
                          const SizedBox(width: 30,),
                          Text(orderController.deliveryFee.value.date, style: const TextStyle(fontSize: 12, color: Colors.grey))
                        ]
                    ),
                  if(myValue==3 && orderController.shipmentMethod.value==3)
                    Obx(() => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: orderController.shipmentMethodErrorMessage.value.isNotEmpty
                              ? Colors.red
                              : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                            child: Text("choose company".tr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 120.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              itemCount: orderController.shipmentCompanies.length,
                              itemBuilder: (context, index) {
                                var company = orderController.shipmentCompanies[index];
                                return Obx(()=> shipmentCompanyCard(company.getIconPath(),company.id, company.name));
                              },
                            ),
                          ),
                          if(orderController.shipmentCompanyNote.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset("icons/info.png",width: 24,),
                                    const SizedBox(width: 10,),
                                    Text("shipment note".tr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(orderController.shipmentCompanyNote.value, style: const TextStyle(fontSize: 14  , color: Colors.grey)),
                                ),
                              ],
                            ),
                          ),
                          if (orderController.shipmentCompanyErrorMessage.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Text(
                                orderController.shipmentCompanyErrorMessage.value,
                                style: const TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                    )),
                ],
              )
          )
      ),
    );
  }
  Widget addressCard(DeliveryAddressModel addressModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 0.2),borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(addressModel.getRecipientName ,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(addressModel.fullAddress,
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

        InkWell(
          onTap: () async {
            var result = await Get.to(() => const ChooseDeliveryAddressList());
            if (result != null) {
              if (result != null && result is DeliveryAddressModel) {
                orderController.deliveryAddress.value = result;
                orderController.deliveryAddressId.value = result.id ?? 0;
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('update address'.tr,style: const TextStyle(fontSize: 16,color: primaryColor,decoration: TextDecoration.underline,)),
          ),
        ),
      ],
    );
  }
}

