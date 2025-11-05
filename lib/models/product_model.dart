import 'package:get/get.dart';

import '../common/api_paths.dart';

class ProductModel {
  int id;
  int categoryId;
  int unitId;
  String name;
  RxDouble basePrice = 0.0.obs;
  double vat = 0;
  RxDouble discountPercentage = 0.0.obs;
  String desc;
  String thumbPath;
  List<Attribute>? attributes;

  ProductModel(
      {
        required this.id,
        required this.categoryId,
        required this.unitId,
        required this.name,
        required this.desc,
        required this.thumbPath,
        required this.vat,
        required double basePrice,
        required double discountPercentage,
        this.attributes
      })
  {
    this.basePrice.value = basePrice;
    this.discountPercentage.value = discountPercentage;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        desc: json['desc'],
        basePrice: json['price'],
        vat: json['vaT_Rate'],
        unitId: json['unitId'],
        discountPercentage: json['discountPercentage'],
        thumbPath: json['thumbPath']
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    try{
      return jsonList.map((item) => ProductModel.fromJson(item)).toList();
    }
    catch(e){}
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'vaT_Rate': vat,
      'unitId': unitId,
      'desc': desc,
      'thumbPath': thumbPath,
      'price': basePrice.value,
      'discountPercentage': discountPercentage.value,
    };
  }
  //Computed Values
  double get discountedBasePrice => basePrice.value-(discountPercentage.value * basePrice.value);
  double get priceIncludeVat => discountedBasePrice + ((vat * discountedBasePrice) / 100);

  //Display Helpers
  String getDiscountRate(){
    if(discountPercentage.value==0)return "";
    return "${(discountPercentage*100).toInt()}% ";
  }

  String getPreDiscountPrice(){
    if(discountPercentage.value==0) return "";
    return "${basePrice.value.toStringAsFixed(2)} ريال";
  }
  String getThumbPath(){
    String path = thumbPath;
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
  }
}

class Attribute {
  String? label;
  String? value;
  Attribute({this.label, this.value});
}
