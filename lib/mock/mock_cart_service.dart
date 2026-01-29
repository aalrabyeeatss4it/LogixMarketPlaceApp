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
              id: 1,
              vat: 1,
              unitId: 1,
              categoryId: 1,
              basePrice: 126.5,
              // preDiscountPrice: 126.5,
              discountPercentage: 0,
              name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
              desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
              thumbPath: 'assets_mock/product1.png',
              productCode: 'Pro-01',
              inventoryBalance: 0)
      ),
      CartItemModel(
          product: ProductModel(
              id: 2,
              vat: 2,
              unitId: 2,
              categoryId: 1,
              basePrice: 126.5,
              // preDiscountPrice: 320,
              discountPercentage: 0,
              name: 'خلّاط مغسلة مرتفع – أسود مطفي',
              desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
              thumbPath: 'assets_mock/product2.png',
              productCode: 'Pro-01',  inventoryBalance: 0)
      )
    ];
    return items;
  }
}
