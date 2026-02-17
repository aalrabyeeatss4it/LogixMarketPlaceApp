import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logix_market_place/models/product_image_model.dart';

import '../common/api_paths.dart';

class ProductModel {
  int id;
  int categoryId;
  int unitId;
  String name;
  String? productCode;
  RxDouble basePrice = 0.0.obs;
  RxDouble discountPercentage = 0.0.obs;
  RxInt inventoryBalance = 0.obs;
  double vat = 0;
  String desc;
  String thumbPath;
  List<Attribute>? attributes;
  List<ProductImageModel>? files;

  ProductModel(
      {
        required this.id,
        required this.categoryId,
        required this.unitId,
        required this.name,
        required this.desc,
        required this.thumbPath,
        required this.vat,
        required this.productCode,
        required double basePrice,
        required double discountPercentage,
        required int inventoryBalance,
        this.attributes,
        this.files
      })
  {
    this.inventoryBalance.value = inventoryBalance;
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
        vat: json['vaT_Rate']??0,
        unitId: json['unitId'],
        discountPercentage: json['discountPercentage'],
        inventoryBalance: json['inventoryBalance']??0,
        productCode: json['productCode']??"",
        thumbPath: json['thumbPath'],
        files: ProductImageModel.fromJsonList(json['files'])
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    try{
      return jsonList.map((item) => ProductModel.fromJson(item)).toList();
    }
    catch(e){
      print("List<ProductImageModel> fromJsonList"+e.toString());
    }
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
      'productCode': productCode,
      'price': basePrice.value,
      'discountPercentage': discountPercentage.value,
      'inventoryBalance': inventoryBalance.value,
    };
  }
  //Computed Values
  double get discountedBasePrice => basePrice.value-(discountPercentage.value * basePrice.value);
  double get priceIncludeVat => discountedBasePrice + ((vat * discountedBasePrice) / 100);
  double get vatValue => ((vat * discountedBasePrice) / 100);

  //Display Helpers
  String get getPriceIncludeVat=> (priceIncludeVat>0)?priceIncludeVat.toStringAsFixed(2):"";
  String getDiscountRate(){
    if(discountPercentage.value==0) return "";
    return "${(discountPercentage*100).toInt()}% ";
  }

  int isAvailable(int qty){
    if(inventoryBalance.value==0) {
      return -1;
    }
    else if(inventoryBalance.value> qty) {
      return 1;
    } else if(inventoryBalance.value == qty) {
      return 0;
    }
    return -1;
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

  String getProductCode(){
    if(productCode == null || productCode == "") return "";
    return productCode!;
  }
}
class Attribute {
  String? label;
  String? value;
  Attribute({this.label, this.value});
}