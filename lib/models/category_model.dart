import 'package:logix_market_place/common/api_paths.dart';

class CategoryModel {
  int id;
  String nameAr;
  String? nameEn;
  String? thumbPath;

  CategoryModel(
      {required this.id,
      required this.nameAr,
      this.nameEn,
      required this.thumbPath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        nameAr: json['nameAr'],
        nameEn: json['nameEn'],
        thumbPath: json['thumbPath']);
  }

  static List<CategoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => CategoryModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'thumbPath': thumbPath
    };
  }
  String getThumbPath(){
    String path = thumbPath??"no_image.jpg";
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
  }
}
