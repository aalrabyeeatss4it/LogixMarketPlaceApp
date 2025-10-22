import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';
import '../../models/order_model.dart';

class OrderSummaryCard extends StatelessWidget{
  final OrderModel order ;

  const OrderSummaryCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // elevation: 0,
        // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey,width: 0),borderRadius: BorderRadius.circular(10)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primaryColor.withOpacity(0.1)),
        // color: primaryColor.withOpacity(0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('رقم الطلب',style: TextStyle(fontSize: 16)),
                  Text('#${order.orderId?? ""}',style: TextStyle(fontSize: 16),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('السلع',style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Text(order.subTotal?? "0",style: TextStyle(fontSize: 16),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset('icons/riyal.png' ,width: 12,),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('التسليم والشحن',style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                        child: Text(order.deliveryFee?? "0",style: TextStyle(fontSize: 16),),
                      ),
                      Image.asset('icons/riyal.png' ,width: 12,)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('الحالة',style: TextStyle(fontSize: 16),),
                  Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      color: (order.paymentMethodId=="4")?secondaryColor : primaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        child: Text(order.paymentMethod??"",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('إجمالي الطلب',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                        child: Text(order.total?? "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                      ),
                      Image.asset('icons/riyal.png' ,width: 12,)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}