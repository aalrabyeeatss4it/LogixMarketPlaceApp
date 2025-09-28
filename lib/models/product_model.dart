class ProductModel {
  int productId;
  int categoryId;
  String productNameAr;
  String productNameEn;
  String productThumbPath;

  ProductModel(
      {required this.productId,
      required this.categoryId,
      required this.productNameAr,
      required this.productNameEn,
      required this.productThumbPath});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['productId'],
        categoryId: json['categoryId'],
        productNameAr: json['productNameAr'],
        productNameEn: json['productNameEn'],
        productThumbPath: json['productThumbPath']);
  }
  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ProductModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'productNameAr': productNameAr,
      'productNameEn': productNameEn,
      'productThumbPath': productThumbPath
    };
  }
}
