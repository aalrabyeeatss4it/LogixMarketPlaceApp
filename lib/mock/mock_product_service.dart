import 'package:logix_market_place/models/product_model.dart';

import '../services/product_service.dart';

class MockProductService implements ProductService {
  @override
  Future<List<ProductModel>> getList() async {
    List<ProductModel> products = [
      ProductModel(
          productId: 1,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productThumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          productId: 2,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productThumbPath: 'assets_mock/product2.png'
      ),
      ProductModel(
          productId: 3,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productThumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          productId: 4,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productThumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          productId: 5,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productThumbPath: 'assets_mock/product2.png'
      )
    ];
    return products;
  }
}
