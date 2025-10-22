import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import 'common/lang/app_translations.dart';
import 'common/localization/localization_controller.dart';
import 'common/nav/app_wrapper.dart';
import 'controllers/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LocalizationController localizationController = Get.put(LocalizationController());
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(600, 1000),
        builder: (c, child) {
          return AppWrapper(
            child: GetMaterialApp(
              initialBinding: AppBindings(),
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
              fallbackLocale: const Locale('ar', 'SA'),
              initialRoute:(loginController.isLoggedIn.value)? RouteNames.homePage: RouteNames.loginPage,
              getPages: routePages ,
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // Accept all certificates
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}