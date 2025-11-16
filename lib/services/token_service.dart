import 'dart:convert';
import 'package:http/http.dart';
import '../common/api_paths.dart';
import 'my_service.dart';

class TokenService extends MyService{
  Future<String> getToken() async {
    String token = "";
    Response response = await getData(ssoTokenPath);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      token = json['token'];
    }
    return token;
  }
}
