import 'package:get/get.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/fav_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../mock/mock_fav_service.dart';

class FavController extends GetxController {
  RxList<ProductModel> items = <ProductModel>[].obs;
  FavService favService = Get.put(MockFavService());
  RxBool loading = true.obs;

  Future<void> addItem(ProductModel item) async {
    loading.value = true;
    var result = await favService.addItem(item);
    if (result is SuccessStatus) {
      items.add(item);
    }
    else{
    }
    loading.value = false;
  }

  bool inFav(int productId) {
    return items.any((item) => item.productId == productId);
  }


  Future<void> removeItem(ProductModel item) async {
    loading.value = true;
    items.remove(item);
    var result = favService.removeItem(item);
    if (result is SuccessStatus) {
      items.remove(item);
    }
    loading.value = false;
  }


  Future<void> getList() async {
    loading.value = true;
    var list = await favService.getList();
    items.value = list;
    loading.value = false;
  }
}
