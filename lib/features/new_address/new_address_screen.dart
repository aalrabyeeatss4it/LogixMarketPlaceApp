import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/widgets/section_title_card.dart';
import 'package:logix_market_place/features/new_address/new_address_form.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';


class NewAddressScreen extends StatelessWidget{
  final CartController cartController = Get.put(CartController());

  NewAddressScreen({super.key});

  final bool isDefaultAddress = false; // state for checkbox
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Form(
          child: SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const SectionTitleCard(title: "اضافة عنوان جديد"),
                    NewAddressForm()
                  ]
              )
          ),
        )
    );
  }
}