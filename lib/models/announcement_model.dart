import 'package:logix_market_place/common/api_paths.dart';

class AnnouncementModel {
  int id;
  String subject;
  String? details;
  String? attachFilePath;

  AnnouncementModel(
      {required this.id,
      required this.subject,
      this.details,
      required this.attachFilePath});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
        id: json['id'],
        subject: json['subject'],
        details: json['details'],
        attachFilePath: json['attachFilePath']);
  }

  static List<AnnouncementModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => AnnouncementModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'details': details,
      'attachFilePath': attachFilePath
    };
  }
  String getFilePath(String ssoToken){
    String path = attachFilePath??"no_image.jpg";
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+attachFilePath?.replaceAll('~/','/').replaceAll(' ', '')+"?token=$ssoToken";
  }
}