import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';
import '../../models/delivery_address_model.dart';

class AddressCard extends StatelessWidget{
  const AddressCard({super.key, required this.addressModel});
  final DeliveryAddressModel addressModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 0.2),borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
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

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('تغيير العنوان',style: TextStyle(fontSize: 16,color: primaryColor,decoration: TextDecoration.underline,)),
        ),
      ],
    );
  }

}