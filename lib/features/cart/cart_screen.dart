import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../controllers/category_controller.dart';
import '../home/category_card.dart';

class CartScreen extends StatelessWidget{
    final CategoryController categoryController = Get.put(CategoryController());
    CartScreen({super.key});

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
                      Center(child: Text('Cart'),),
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