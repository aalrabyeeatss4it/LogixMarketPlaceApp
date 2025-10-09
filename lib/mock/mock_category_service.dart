import 'package:logix_market_place/models/category_model.dart';
import 'package:logix_market_place/services/category_service.dart';

class MockCategoryService implements CategoryService{
  @override
  Future<List<CategoryModel>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<CategoryModel> categories = [
      CategoryModel(thumbPath: "assets_mock/cat1.png", nameAr: "الرخام الصناعي", id: 1),
      CategoryModel(thumbPath: "assets_mock/cat2.png", nameAr: "بديل الرخام", id: 2),
      CategoryModel(thumbPath: "assets_mock/cat3.png", nameAr: "الخلاطات", id: 3),
      CategoryModel(thumbPath: "assets_mock/cat4.png", nameAr: "المغاسل الجاهزة", id: 4),
      CategoryModel(thumbPath: "assets_mock/cat1.png", nameAr: "الرخام الصناعي", id: 5),
      CategoryModel(thumbPath: "assets_mock/cat2.png", nameAr: "بديل الرخام", id: 6),
      CategoryModel(thumbPath: "assets_mock/cat3.png", nameAr: "الخلاطات", id: 7),
      CategoryModel(thumbPath: "assets_mock/cat4.png", nameAr: "المغاسل الجاهزة", id: 8),
    ];
    return categories;
  }

}