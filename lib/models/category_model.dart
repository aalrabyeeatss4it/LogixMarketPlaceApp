class CategoryModel {
  String categoryId;
  String categoryNameAr;
  String? categoryNameEn;
  String categoryThumbPath;

  CategoryModel(
      {required this.categoryId,
      required this.categoryNameAr,
      this.categoryNameEn,
      required this.categoryThumbPath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryId: json['categoryId'],
        categoryNameAr: json['categoryNameAr'],
        categoryNameEn: json['categoryNameEn'],
        categoryThumbPath: json['categoryThumbPath']);
  }

  static List<CategoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => CategoryModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryNameAr': categoryNameAr,
      'categoryNameEn': categoryNameEn,
      'categoryThumbPath': categoryThumbPath
    };
  }
}
