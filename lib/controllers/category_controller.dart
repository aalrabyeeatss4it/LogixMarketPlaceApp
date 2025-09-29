import 'package:get/get.dart';
import 'package:logix_market_place/mock/mock_category_service.dart';
import 'package:logix_market_place/services/category_service.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController{
  RxList<CategoryModel> list = <CategoryModel>[].obs;
  CategoryService service = Get.put(MockCategoryService());

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList()async {
    list.value = await  service.getList();
  }
}