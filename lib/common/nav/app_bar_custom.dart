import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localization/localization_controller.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
   AppBarCustom({super.key, required this.title});
  final String title;
  final LocalizationController controller = Get.find();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), actions: [
      IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            if (Get.locale?.languageCode == 'en') {
              controller.changeLanguage('ar');
            } else {
              controller.changeLanguage('en');
            }
          })
    ]);
  }
}
