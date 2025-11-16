import 'package:get/get.dart';
import 'package:logix_market_place/services/product_service.dart';
import '../models/product_model.dart';


class ProductController extends GetxController {
  var isLoading = false.obs;
  RxList<ProductModel> recentlyArrivedProducts = <ProductModel>[].obs;
  RxList<ProductModel> mostRequestedProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  ProductService productService = Get.put(ProductService());

  Future<void> getRecentlyArrived() async {
    recentlyArrivedProducts.value = await productService.getRecentlyArrived();
  }

  Future<void> getMostRequested() async {
    mostRequestedProducts.value = await productService.getMostRequested();
  }

  Future<void> getByCategory(int categoryId) async {
    isLoading.value = true;
    categoryProducts.clear();
    try {
      var result = await productService.getByCategory(categoryId);
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
