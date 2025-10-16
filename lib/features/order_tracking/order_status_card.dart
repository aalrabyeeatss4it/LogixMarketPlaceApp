import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';

class OrderStatusCard extends StatelessWidget{
  const OrderStatusCard({super.key, required this.label, required this.icon, required this.isActive});
  final String label;
  final String icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(height: 30,child: Image.asset(icon, color:(isActive)? primaryColor : Colors.grey,)
            ),
          ),
        ),
        Text(label,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:(isActive)? primaryColor : Colors.grey,)),
      ],
    );
  }

}