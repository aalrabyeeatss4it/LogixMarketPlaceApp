class ProductModel {
  int productId;
  int categoryId;
  String productName;
  String productDesc;
  String productThumbPath;
  List<Attribute>? attributes;

  ProductModel(
      {required this.productId,
      required this.categoryId,
      required this.productName,
      required this.productDesc,
      required this.productThumbPath,
      this.attributes});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['productId'],
        categoryId: json['categoryId'],
        productName: json['productName'],
        productDesc: json['productDesc'],
        productThumbPath: json['productThumbPath']
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ProductModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'productName': productName,
      'productDesc': productDesc,
      'productThumbPath': productThumbPath
    };
  }
}

class Attribute {
  String? label;
  String? value;
  Attribute({this.label, this.value});
}
