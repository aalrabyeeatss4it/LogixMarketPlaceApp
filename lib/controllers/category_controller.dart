import 'package:get/get.dart';
import 'package:logix_market_place/services/category_service.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController{
  RxList<CategoryModel> list = <CategoryModel>[].obs;
  RxList<CategoryModel> guestCategories = <CategoryModel>[].obs;
  CategoryService service = Get.put(CategoryService());

  @override
  void onInit() {
    super.onInit();
    list = <CategoryModel>[].obs;
    guestCategories = <CategoryModel>[].obs;
  }

  Future<void> getAll() async {
    list.value = await  service.getAll();
  }
  Future<void> getGuestCategories() async {
    guestCategories.value = await  service.getGuestCategories();
  }
}