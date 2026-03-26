import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/fcm_token_dto.dart';

class FcmService extends MyService {
  Future<ServiceResult<dynamic>> sendFcmToken(FcmTokenDto fcmToken) async {
    Response response = await post(Uri.parse(baseUrl + sendFcmTokenPath),
        body: jsonEncode(fcmToken.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer " + box.read(tokenIndex)
        }
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return SuccessStatus<String>(data: json['data'] as String);
    }
    if (response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return FailureStatus(errorMessage: json['message']??'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
    }
    return FailureStatus(errorMessage: 'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
  }
}