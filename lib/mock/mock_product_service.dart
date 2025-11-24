import 'package:get_storage/src/storage_impl.dart';
import 'package:http/src/response.dart';
import 'package:logix_market_place/models/product_model.dart';

import '../services/product_service.dart';

class MockProductService implements ProductService {
  @override
  Future<List<ProductModel>> getRecentlyArrived(String filters) async {
    List<ProductModel> products = [
      ProductModel(
          id: 1,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 300,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 2,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 200,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 3,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 450,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 4,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 240,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 5,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 250,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png', inventoryBalance: 0
      )
    ];
    return products;
  }
  @override
  Future<List<ProductModel>> getByCategory(String filters) async {
    List<ProductModel> products = [
      ProductModel(
          id: 1,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 300,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 2,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 200,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 3,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 450,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 4,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 240,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0
      ),
      ProductModel(
          id: 5,
          categoryId: 1,
          basePrice: 126.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 250,
          discountPercentage: 0,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png', inventoryBalance: 0
      )
    ];
    return products;
  }

  @override
  Future<List<ProductModel>> getMostRequested() {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getRelated() {
    throw UnimplementedError();
  }

  @override
  // TODO: implement box
  GetStorage get box => throw UnimplementedError();

  @override
  Future<Response> getData(String path) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<Response> postData(String path, Map<String, dynamic> json) {
    // TODO: implement postData
    throw UnimplementedError();
  }

  @override
  Future<Response> postLogin(String path, Map<String, dynamic> json) {
    // TODO: implement postLogin
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getGuestProducts(String filters) {
    // TODO: implement getGuestProducts
    throw UnimplementedError();
  }
}
