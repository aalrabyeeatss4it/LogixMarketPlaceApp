import 'dart:core';
import 'package:get/get.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
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
    locale.value = getLocaleFromCode(code);
    Get.updateLocale(locale.value);
  }

  Future<String> getLanguage() async {
    String? code = box.read("preferred_language");
    return code?? "ar";
  }

  void changeLanguage(String langCode) async {
    locale.value = getLocaleFromCode(langCode);
    Get.updateLocale(locale.value);
    box.write("preferred_language", langCode);
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
