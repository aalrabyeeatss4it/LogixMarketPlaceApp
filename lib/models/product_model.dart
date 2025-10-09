import '../common/api_paths.dart';

class ProductModel {
  int id;
  int categoryId;
  String name;
  String discountPercentage;
  double price;
  double preDiscountPrice;
  String desc;
  String thumbPath;
  List<Attribute>? attributes;

  ProductModel(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.desc,
      required this.thumbPath,
      required this.discountPercentage,
      required this.preDiscountPrice,
      required this.price,
      this.attributes});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        desc: json['desc'],
        price: json['price'],
        // discountPercentage: json['discountPercentage'],
        discountPercentage: '- 12% ',
        preDiscountPrice: json['preDiscountPrice'],
        thumbPath: json['thumbPath']
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ProductModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'desc': desc,
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

class Attribute {
  String? label;
  String? value;
  Attribute({this.label, this.value});
}
