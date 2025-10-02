import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/cart_service.dart';
import '../services/service_result.dart';

class MockCartService implements CartService {

  @override
  Future<ServiceResult> addItem(CartItemModel item) async {
    return SuccessStatus();
  }

  @override
  Future<ServiceResult> removeItem(CartItemModel item)  async {
    return SuccessStatus();
  }

  @override
  Future<ServiceResult> decrementQuantity(CartItemModel item)  async {
    return SuccessStatus();
  }

  @override
  Future<ServiceResult> incrementQuantity(CartItemModel item)  async {
    return SuccessStatus();
  }

  @override
  Future<List<CartItemModel>> getList() async {
    List<CartItemModel> items = [
      CartItemModel(
          product: ProductModel(
              productId: 1,
              categoryId: 1,
              productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
              productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
              productThumbPath: 'assets_mock/product1.png')
      ),
      CartItemModel(
          product: ProductModel(
              productId: 2,
              categoryId: 1,
              productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
              productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
              productThumbPath: 'assets_mock/product2.png')
      )
    ];
    return items;
  }
}
