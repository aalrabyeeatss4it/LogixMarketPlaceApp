import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logix_market_place/models/category_model.dart';

class CategoryCard extends StatelessWidget{
  const CategoryCard({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(width:60, height: 60,child: Image.asset(category.categoryThumbPath,fit: BoxFit.fill,)),
                Text(category.categoryNameAr,style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        )
    );
  }

}