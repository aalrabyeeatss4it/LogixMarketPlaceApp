import 'package:logix_market_place/models/category_model.dart';
import 'package:logix_market_place/services/category_service.dart';

class MockCategoryService implements CategoryService{
  @override
  Future<List<CategoryModel>> getList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<CategoryModel> categories = [
      CategoryModel(categoryThumbPath: "assets_mock/cat1.png", categoryNameAr: "الرخام الصناعي", categoryId: 1),
      CategoryModel(categoryThumbPath: "assets_mock/cat2.png", categoryNameAr: "بديل الرخام", categoryId: 2),
      CategoryModel(categoryThumbPath: "assets_mock/cat3.png", categoryNameAr: "الخلاطات", categoryId: 3),
      CategoryModel(categoryThumbPath: "assets_mock/cat4.png", categoryNameAr: "المغاسل الجاهزة", categoryId: 4),
      CategoryModel(categoryThumbPath: "assets_mock/cat1.png", categoryNameAr: "الرخام الصناعي", categoryId: 5),
      CategoryModel(categoryThumbPath: "assets_mock/cat2.png", categoryNameAr: "بديل الرخام", categoryId: 6),
      CategoryModel(categoryThumbPath: "assets_mock/cat3.png", categoryNameAr: "الخلاطات", categoryId: 7),
      CategoryModel(categoryThumbPath: "assets_mock/cat4.png", categoryNameAr: "المغاسل الجاهزة", categoryId: 8),
    ];
    return categories;
  }

}