import 'package:flutter/cupertino.dart';
import 'package:logix_market_place/models/product_model.dart';

class AttributeCard extends StatelessWidget{
  const AttributeCard({super.key, required this.attribute});
  final Attribute attribute;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(attribute.label??'',style: const TextStyle(fontWeight: FontWeight.bold),),
        (attribute.value!=null)?  const Text(' :'):const Text('.'),
        Text(attribute.value?? '')
      ],
    );
  }

}