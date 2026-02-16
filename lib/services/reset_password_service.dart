import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../models/user_password_model.dart';
import 'my_service.dart';

class ResetPasswordService extends MyService {
  Future<ServiceResult> sendOtpEmail(UserPasswordModel pwd) async {
    Response response = await postLogin(sendOtpEmailPath, pwd.toJson());
    print("sendOtpEmail");
    print("sendOtpEmail"+response.body);
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    var error = jsonDecode(response.body);
    return FailureStatus(errorMessage: error["message"]);
  }

  Future<ServiceResult> verifyOTP(UserPasswordModel pwd) async {
    Response response = await postLogin(verifyOTPPath, pwd.toJson());
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    var error = jsonDecode(response.body);
    return FailureStatus(errorMessage: error["message"]);
  }

  Future<ServiceResult> resetPassword(UserPasswordModel pwd) async {
    Response response = await postLogin(resetPasswordPath, pwd.toJson());
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    var error = jsonDecode(response.body);
    return FailureStatus(errorMessage: error["message"]);
  }
}
