import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/trans_model.dart';

import '../../common/nav/page_routes.dart';
import '../../common/theme/colors.dart';
import '../../models/order_model.dart';

class TransactionCard extends StatelessWidget{
  final TransModel trans;

  const TransactionCard({super.key, required this.trans});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("المبلغ:",style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(trans.amount??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                              const SizedBox(width: 3),
                              Image.asset('icons/riyal.png' ,width: 14,color: Colors.black,),
                            ]
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('التاريخ:',style: TextStyle(fontSize: 18,color: Colors.grey),),
                          ),
                          const SizedBox(width: 5,),
                          Text(trans.transDate??"",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("البيان:",style: TextStyle(fontSize: 16),),
                          SizedBox(width: 5,),
                          Text(trans.description??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)
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