import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logix_market_place/services/product_service.dart';

import '../mock/mock_product_service.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  RxList<ProductModel> list = <ProductModel>[].obs;
  ProductService productService = Get.put(MockProductService());
  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
    list.value = await productService.getList();
  }
}
