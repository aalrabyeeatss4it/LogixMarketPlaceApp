import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../localization/localization_controller.dart';
import '../theme/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  AppBarCustom({super.key, required this.title});
  final String title;
  final LocalizationController controller = Get.find();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      title: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(15.r),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "البحث في قصر لورا ..",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
            ),
          )
      ),
    );
  }
}
