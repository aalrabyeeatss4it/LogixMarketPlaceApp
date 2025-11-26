import 'package:get/get.dart';
import 'package:logix_market_place/services/guest_product_detail_service.dart';
import 'package:share_plus/share_plus.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/product_model.dart';
import '../services/product_detail_service.dart';
import 'login_controller.dart';

class ProductDetailController extends GetxController {
  late Rx<ProductModel> product = Rx<ProductModel>(
      ProductModel(
        id: 0,
        name: '',
        desc: '',
        basePrice: 0,
        vat: 0,
        unitId: 0,
        discountPercentage: 0,
        categoryId: 0,
        thumbPath: '', inventoryBalance: 0
      )
  );
  RxBool loading = true.obs;
  RxInt quantity = 1.obs;
  void setQty(int qty){
    quantity.value = qty;
  }
  void updateProduct(int qty, ProductModel p){
    quantity.value = qty;
    product.value.basePrice.value = p.basePrice.value;
    product.value.discountPercentage.value = p.discountPercentage.value;
  }
  late final ProductDetailService productDetailService;

  @override
  void onInit() {
    super.onInit();
    print("checkLoggedIn"+checkLoggedIn().toString());
    if (checkLoggedIn()) {
      Get.replace(ProductDetailService());
      productDetailService = Get.find<ProductDetailService>();
    } else {
      Get.replace(GuestProductDetailService());
      productDetailService = Get.find<GuestProductDetailService>();
    }
    print("Service type: ${productDetailService.runtimeType}");
  }
  RxList<ProductModel> relatedProducts = <ProductModel>[].obs;

  Future<void> shareProductLink() async {
    String link = erpUrl()+"/p/"+product.value.id.toString();
    final result = await Share.share(
        "Check out this product: $link",
        subject: "Product Link");

    if (result.status == ShareResultStatus.success) {
      print("Shared successfully to: ${result.raw}");
    } else if (result.status == ShareResultStatus.dismissed) {
      print("Share dialog dismissed");
    } else {
      print("Share failed or was not available");
    }
  }

  Future<void> getProduct(int productID) async {
    loading.value = true;
    print("productDetailService.getProduct:"+productDetailService.toString());
    var p = await productDetailService.getProduct(productID, quantity.value);
    if(p != null){
      product.value = p;
      getRelatedProducts();
    }
    loading.value = false;
  }

  Future<void> getRelatedProducts() async {
    relatedProducts.value = await productDetailService.getRelatedProducts(product.value.id);
  }
}
