import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocalizationController extends GetxController {
  Rx<Locale> locale = const Locale('ar', 'SA').obs;

  @override
  void onInit() {
    super.onInit();
    setLocale();
  }

  void setLocale() async {
    String? code = await getLanguage();
    if (code != null) {
      locale.value = getLocaleFromCode(code);
      Get.updateLocale(locale.value);
    }
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('preferred_language');
    return code;
  }

  void changeLanguage(String langCode) async {
    locale.value = getLocaleFromCode(langCode);
    Get.updateLocale(locale.value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', langCode);
  }

  Locale getLocaleFromCode(String code) {
    switch (code) {
      case 'ar':
        return const Locale('ar', 'SA');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }
}
