import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLanguagePreference(String langCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('preferred_language', langCode);
}
onLanguageSelected(String code) {
  saveLanguagePreference(code);
}
