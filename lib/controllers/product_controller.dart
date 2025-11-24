import 'package:get/get.dart';
import 'package:logix_market_place/controllers/product_filter_controller.dart';
import 'package:logix_market_place/services/product_service.dart';
import '../models/product_model.dart';
import 'login_controller.dart';


class ProductController extends GetxController {
  var isLoading = false.obs;
  RxList<ProductModel> guestProducts = <ProductModel>[].obs;
  RxList<ProductModel> recentlyArrivedProducts = <ProductModel>[].obs;
  RxList<ProductModel> mostRequestedProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  ProductService productService = Get.put(ProductService());

  Future<void> getGuestProducts() async {
    isLoading.value = true;
    guestProducts.clear();
    Get.find<ProductFilterController>().setCategory(0);
    var filters = Get.find<ProductFilterController>().getQuery();
    try {
      var result = await productService.getGuestProducts(filters);
      guestProducts.assignAll(result);
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> getRecentlyArrived() async {
    isLoading.value = true;
    recentlyArrivedProducts.clear();
    Get.find<ProductFilterController>().setCategory(0);
    var filters = Get.find<ProductFilterController>().getQuery();
    try {
      var result = await productService.getRecentlyArrived(filters);
      recentlyArrivedProducts.assignAll(result);
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> getMostRequested() async {
    mostRequestedProducts.value = await productService.getMostRequested();
  }

  Future<void> getByCategory(int categoryId) async {
    isLoading.value = true;
    categoryProducts.clear();
    Get.find<ProductFilterController>().setCategory(categoryId);
    var filters = Get.find<ProductFilterController>().getQuery();
    try {
      var result =  (Get.put(LoginController()).checkLoggedIn())? await productService.getRecentlyArrived(filters): await productService.getGuestProducts(filters);
      categoryProducts.assignAll(result);
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }
}
