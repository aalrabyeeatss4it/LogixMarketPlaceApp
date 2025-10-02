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
          productId: 1,
          categoryId: 1,
          productName:
              'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productDesc:
              'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productThumbPath: 'assets_mock/product1.png'),
      ProductModel(
          productId: 2,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productThumbPath: 'assets_mock/product2.png')
    ];
    return items;
  }
}
