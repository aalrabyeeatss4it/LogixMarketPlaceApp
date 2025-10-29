import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/cart_service.dart';
import 'package:logix_market_place/services/fav_service.dart';
import '../services/service_result.dart';

class MockFavService implements FavService {
  @override
  Future<ServiceResult> addItem(ProductModel item) async {
    return SuccessStatus();
  }

  @override
  Future<ServiceResult> removeItem(ProductModel item) async {
    return SuccessStatus();
  }

  @override
  Future<List<ProductModel>> getList() async {
    List<ProductModel> items = [
      ProductModel(
          id: 1,
          categoryId: 1,
          price: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 500,
          discountPercentage: 10,
          name:
              'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc:
              'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png'),
      ProductModel(
          id: 2,
          categoryId: 1,
          price: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 500,
          discountPercentage: 10,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png')
    ];
    return items;
  }
}
