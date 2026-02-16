import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/nav/page_routes.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/login_controller.dart';
import 'common/dynamic_links/deep_link_service.dart';
import 'common/lang/app_translations.dart';
import 'common/localization/localization_controller.dart';
import 'common/storage/local_storage.dart';
import 'controllers/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  box.remove(debitPopupShown);
  final deepLinkService = DeepLinkService();

  runApp(MyApp(deepLinkService: deepLinkService));
}

class MyApp  extends StatefulWidget {
  const MyApp({super.key, required this.deepLinkService});
  final DeepLinkService deepLinkService;

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState  extends State<MyApp> {
  final LocalizationController localizationController = Get.put(LocalizationController());
  final LoginController loginController = Get.put(LoginController());
  DateTime? lastPressed;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();
    widget.deepLinkService.init();
    // testDeepLink();
  }

  void testDeepLink() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final testUri = Uri.parse("https://market.logix-erp.com/p/12345");
      widget.deepLinkService.handleDeepLink(testUri);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(600, 1000),
        builder: (c, child) {
          return GetMaterialApp(
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
            initialRoute:(isLoggedIn())? RouteNames.homePage: RouteNames.guestHomePage,
            getPages: routePages ,
          );
        });
  }
  @override
  void dispose() {
    widget.deepLinkService.dispose();
    super.dispose();
  }

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}