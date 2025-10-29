import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../mock/mock_product_detail_service.dart';
import '../models/product_model.dart';

class ProductDetailController extends GetxController {
  late Rx<ProductModel> product = Rx<ProductModel>(
      ProductModel(
        id: 0,
        name: '',
        desc: '',
        price: 0,
        vat: 0,
        unitId: 0,
        discountPercentage: 0,
        categoryId: 0,
        thumbPath: ''
      )
  );
  RxBool loading = true.obs;
  RxInt quantity = 1.obs;
  void setQty(int qty){
    quantity.value = qty;
  }
  MockProductDetailService productDetailService = Get.put(MockProductDetailService());
  RxList<ProductModel> relatedProducts = <ProductModel>[].obs;

  Future<void> getProduct(int productID) async {
    loading.value = true;
    var p = await productDetailService.getProduct(productID);
    product.value = p!;
    getRelatedProducts();
    loading.value = false;
  }

  Future<void> getRelatedProducts() async {
    relatedProducts.value = await productDetailService.getRelatedProducts();
  }
}
