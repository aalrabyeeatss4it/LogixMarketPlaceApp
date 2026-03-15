import 'package:get/get.dart';
import 'package:logix_market_place/services/guest_product_detail_service.dart';
import 'package:share_plus/share_plus.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/product_model.dart';
import '../models/product_offer.dart';
import '../services/product_detail_service.dart';
import 'login_controller.dart';

class ProductDetailController extends GetxController {
  late Rx<ProductModel> product = Rx<ProductModel>(
      ProductModel(
        id: 0,
        name: '',
        desc: '',
        basePrice: 0,
          offerPrice: 0,
        vat: 0,
        unitId: 0,
        discountPercentage: 0,
        categoryId: 0,
        thumbPath: '',
          productCode: '',
          inventoryBalance: 0,
          offers: []
      )
  );
  RxBool loading = true.obs;
  RxInt quantity = 1.obs;
  void setQty(int qty){
    quantity.value = qty;
    updateSelectedOffer(qty);
  }
  RxInt selectedOfferId = 0.obs;
  void updateSelectedOffer(int quantity) {
    ProductOffer? offer;

    if (product.value.offers.isNotEmpty) {
      offer = product.value.offers.firstWhere(
            (o) => quantity >= o.qtyFrom && quantity <= o.qtyTo,
        orElse: () => displayOffers.first,
      );
      selectedOfferId.value = offer.id;
    } else {
      selectedOfferId.value = 0;
    }
    print("selectedOfferId.value:"+selectedOfferId.value.toString());
  }

  List<ProductOffer> get displayOffers {
    final baseOffer = ProductOffer(
      id: 0,
      productId: product.value.id,
      qtyFrom: 1,
      qtyTo: 1,
      price:  double.parse(product.value.basePriceIncludeVat.toStringAsFixed(2)),
    );

    return [baseOffer, ...product.value.offers];
  }
  void updateProduct(int qty, ProductModel p){
    quantity.value = qty;
    product.value.basePrice.value = p.basePrice.value;
    product.value.offerPrice.value = p.offerPrice.value;
    product.value.discountPercentage.value = p.discountPercentage.value;
  }
  late final ProductDetailService productDetailService;

  @override
  void onInit() {
    super.onInit();
    print("checkLoggedIn"+isLoggedIn().toString());
    if (isLoggedIn()) {
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
