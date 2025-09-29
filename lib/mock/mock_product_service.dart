import 'package:logix_market_place/models/product_model.dart';

import '../services/product_service.dart';

class MockProductService implements ProductService {
  @override
  Future<List<ProductModel>> getList() async {
    List<ProductModel> products = [
      ProductModel(
          productId: 1,
          categoryId: 1,
          productNameAr: 'خلّاط مغسلة مرتفع – ذهبي لامع',
          productNameEn: 'خلّاط مغسلة مرتفع – ذهبي لامع',
          productThumbPath: 'assets_mock/product1.png'),
      ProductModel(
          productId: 2,
          categoryId: 1,
          productNameAr: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productNameEn: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productThumbPath: 'assets_mock/product2.png')
    ];
    return products;
  }
}
