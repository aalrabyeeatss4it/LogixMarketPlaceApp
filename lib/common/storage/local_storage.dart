import 'package:get_storage/get_storage.dart';

const String tokenIndex = "token";
const String firstNameIndex = "firstNameIndex";
const String lastNameIndex = "lastNameIndex";
const String emailIndex = "emailIndex";
const String userIdIndex = "userIdIndex";
const String userNameIndex = "userNameIndex";
const String pwdIndex = "pwdIndex";
const String customerIDIndex = "customerIDIndex";
const String customerNameIndex = "customerNameIndex";
const String customerPhoneIndex = "customerPhoneIndex";
const String customerTaxNoIndex = "customerTaxNoIndex";
const String rememberMeIndex = "rememberMeIndex";
const String debitPopupShown = "debit_popup_shown";

var box = GetStorage();
isLoggedIn() {
  var token = box.read(tokenIndex);
  return (token != null);
}
