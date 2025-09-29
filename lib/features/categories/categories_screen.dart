import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../controllers/category_controller.dart';
import '../home/category_card.dart';

class CategoriesScreen extends StatelessWidget{
  final CategoryController categoryController = Get.put(CategoryController());
  CategoriesScreen({super.key});

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
                    Obx(() {
                      if(categoryController.list.isEmpty){
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        height: 110,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryController.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryCard(
                                  category: categoryController.list[index]);
                            }),
                      );
                    }
                    ),
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