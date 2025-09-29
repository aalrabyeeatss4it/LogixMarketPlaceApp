import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/nav/app_bar_custom.dart';
import '../../controllers/category_controller.dart';

class ProfileScreen extends StatelessWidget{
    final CategoryController categoryController = Get.put(CategoryController());
    ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: SingleChildScrollView(
          child: Card(
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(child: Text('profile'.tr),),
                      SizedBox(height: 10.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }