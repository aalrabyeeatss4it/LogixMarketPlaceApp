import '../common/api_paths.dart';

class ProductModel {
  int id;
  int categoryId;
  int unitId;
  String name;
  double discountPercentage;
  double price;
  double vat;
  // double preDiscountPrice;
  String desc;
  String thumbPath;
  List<Attribute>? attributes;

  ProductModel(
      {required this.id,
      required this.categoryId,
      required this.unitId,
      required this.name,
      required this.desc,
      required this.thumbPath,
      required this.discountPercentage,
      // required this.preDiscountPrice,
      required this.price,
      required this.vat,
      this.attributes});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        desc: json['desc'],
        price: json['price'],
        vat: json['vaT_Rate'],
        unitId: json['unitId'],
        discountPercentage: json['discountPercentage'],
        // preDiscountPrice: json['preDiscountPrice'],
        thumbPath: json['thumbPath']
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    print("fromJsonList...");
    try{
      return jsonList.map((item) => ProductModel.fromJson(item)).toList();
    }
    catch(e){
      print("toJson--error");
      print(e.toString());
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
        'price': price,
        'discountPercentage': discountPercentage,
        // 'preDiscountPrice': preDiscountPrice
      };
  }

  String getDiscountRate(){
    if(discountPercentage==0)return "";
    return "${(discountPercentage*100).toInt()}% ";
  }

  String getPrice(){
    if(discountPercentage==0) return price.toString();
    return (price-(discountPercentage*price)).toString();
  }

  String getPreDiscountPrice(){
    if(discountPercentage==0) return "";
    return '$priceريال';
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
