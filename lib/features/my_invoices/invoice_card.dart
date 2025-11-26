import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../models/order_model.dart';

class InvoiceCard extends StatelessWidget{
  final OrderModel order;

  const InvoiceCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        order.selected.value = !order.selected.value;
      },
      child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.withOpacity(0.9),width: 0.2),borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Obx(()=>
                            Checkbox(
                            value: order.selected.value,
                            onChanged: (v) {
                              order.selected.value = v!;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4), // square-ish
                            )
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('رقم الفاتورة:',style: TextStyle(fontSize: 18,color: Colors.grey),),
                        ),
                        const SizedBox(width: 5,),
                        Text("${order.orderId??""}#",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                      ],
                    ),
                    (double.parse(order.remaining!)>0)?
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          color: secondaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                            child: Text('غير مسددة بعد.',style: TextStyle(fontSize: 18,color: Colors.white)),
                          ))
                    ):const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            color: paidColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                              child: Text('مسدد',style: TextStyle(fontSize: 18,color: Colors.white)),
                            ))
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: grayBorderColor1.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 7),
                              child: Text(order.orderStatus??"",style: const TextStyle(fontSize: 16,color: Colors.black),),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(order.deliveryDate??"",style: const TextStyle(fontSize: 16,color: Colors.black),),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          Get.toNamed(RouteNames.invoiceDetailsPage, arguments: order);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("تفاصيل أكثر", style: TextStyle(fontSize: 16,color: primaryColor,decoration: TextDecoration.underline),),
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("الإجمالي",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(order.getTotal,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),
                          Image.asset('icons/riyal.png' ,width: 20,color: Colors.black,),
                        ]
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}