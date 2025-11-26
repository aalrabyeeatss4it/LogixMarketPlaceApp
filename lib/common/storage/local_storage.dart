import 'package:get_storage/get_storage.dart';

const String tokenIndex = "token";
const String firstNameIndex = "firstNameIndex";
const String lastNameIndex = "lastNameIndex";
const String emailIndex = "emailIndex";
const String userIdIndex = "userIdIndex";
const String userNameIndex = "userNameIndex";
const String pwdIndex = "pwdIndex";

var box = GetStorage();
checkLoggedIn(){
  var token = box.read(tokenIndex);
  return (token!=null);
}