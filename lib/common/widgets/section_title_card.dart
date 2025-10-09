import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

class SectionTitleCard extends StatelessWidget{
  final String title;
  final bool showMore;
  final double fontSize;
  final VoidCallback? showMoreAction;

  const SectionTitleCard({super.key, required this.title, this.showMore = false, this.fontSize = 18, this.showMoreAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900)),
              showMore?
              InkWell(
                onTap: showMoreAction?? () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text("show more".tr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900,color: primaryColor)),
                      const SizedBox(width: 5),
                      Image.asset('icons/arrow.png',height: 10,)
                    ],
                  ),
                ),
              ):const SizedBox()
            ],
          )
        ],
      ),
    );
  }
}