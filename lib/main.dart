import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common/lang/app_translations.dart';
import 'common/localization/localization_controller.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LocalizationController localizationController = Get.put(LocalizationController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(600, 1000),
        builder: (c, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // 🌍 Setup translations
            translations: AppTranslations(),
            locale: localizationController.locale.value,
            fallbackLocale: const Locale('en', 'US'),

            home: const HomeScreen(),
          );
        });
  }
}
