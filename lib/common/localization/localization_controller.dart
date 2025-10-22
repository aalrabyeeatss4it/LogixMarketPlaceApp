import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocalizationController extends GetxController {
  Rx<Locale> locale = const Locale('ar', 'SA').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('preferred_language');
    if (code != null) {
      locale.value = _getLocaleFromCode(code);
      Get.updateLocale(locale.value);
    }
  }

  void changeLanguage(String langCode) async {
    locale.value = _getLocaleFromCode(langCode);
    Get.updateLocale(locale.value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', langCode);
  }

  Locale _getLocaleFromCode(String code) {
    switch (code) {
      case 'ar':
        return const Locale('ar', 'SA');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }
}
