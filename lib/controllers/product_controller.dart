import 'package:get/get.dart';
import 'package:logix_market_place/services/product_service.dart';
import '../models/product_model.dart';


class ProductController extends GetxController {
  var isLoading = false.obs;
  RxList<ProductModel> list = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  ProductService productService = Get.put(ProductService());

  Future<void> getRecentlyArrived() async {
    list.value = await productService.getRecentlyArrived();
  }

  Future<void> getMostRequested() async {
    list.value = await productService.getRecentlyArrived();
  }

  Future<void> getByCategory(int categoryId) async {
    print("catId:"+categoryId.toString());
    isLoading.value = true;
    list.clear();
    try {
      var result = await productService.getByCategory(categoryId);
      list.assignAll(result);
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }

  }
}
