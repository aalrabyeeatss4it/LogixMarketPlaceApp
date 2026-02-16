import 'dart:ffi';

import '../common/api_paths.dart';

class ProductImageModel{
  int id;
  String imagePath;
  ProductImageModel({required this.id,required this.imagePath});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
        id: json['id'],
        imagePath: json['imagePath']
    );
  }

  static List<ProductImageModel> fromJsonList(List<dynamic>? jsonList) {
    try{
      if(jsonList == null) return [];
      List<ProductImageModel>  list = jsonList.map((item) => ProductImageModel.fromJson(item)).toList();
      print("static List<ProductImageModel> fromJsonList(List<dynamic>? jsonList) {");
      return list;
    }
    catch(e){
      print("fromJsonList"+e.toString());
    }
    return [];
  }

  String getFilePath(String ssoToken){
    String path = imagePath;
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return advertisementErpUrl() + imagesDirPath()+ imagePath.replaceAll('~/','/').replaceAll(' ', '');
    return advertisementErpUrl() + imagesDirPath()+ imagePath.replaceAll('~/','/').replaceAll(' ', '')+"?token=$ssoToken";
  }

}