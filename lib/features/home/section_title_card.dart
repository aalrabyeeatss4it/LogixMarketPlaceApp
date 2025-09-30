import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/theme/colors.dart';

class SectionTitleCard extends StatelessWidget{
  final String title;
  final bool showMore;
  final double fontSize;

  const SectionTitleCard({super.key, required this.title, this.showMore = false, this.fontSize = 16});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900)),
              showMore?
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Text("show more".tr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900,color: primaryColor)),
                    const SizedBox(width: 5),
                    Image.asset('icons/arrow.png',height: 10,)
                  ],
                ),
              ):const SizedBox()
            ],
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

}