import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/announcement_model.dart';
import 'my_service.dart';

class AnnouncementService  extends MyService{

  Future<List<AnnouncementModel>> getAll() async {
    Response response = await getData(announcementsPath);
    if (response.statusCode == 200) {
      var catList = AnnouncementModel.fromJsonList(jsonDecode(response.body));
      return catList;
    }
    return [];
  }
}