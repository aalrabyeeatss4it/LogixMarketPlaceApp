import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/common/theme/colors.dart';

import 'common/lang/app_translations.dart';
import 'common/localization/localization_controller.dart';
import 'features/home/home_screen.dart';
import 'features/home/main_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LocalizationController localizationController = Get.put(LocalizationController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(600, 1000),
        builder: (c, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // scaffoldBackgroundColor: primaryColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            translations: AppTranslations(),
            locale: localizationController.locale.value,
            fallbackLocale: const Locale('en', 'US'),
            initialRoute: RouteNames.mainHomePage,
            getPages: routePages ,
            // home:  MainHomeScreen()
          );
        });
  }
}
