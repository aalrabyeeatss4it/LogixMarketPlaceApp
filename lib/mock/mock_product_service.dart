import 'package:logix_market_place/models/product_model.dart';

import '../services/product_service.dart';

class MockProductService implements ProductService {
  @override
  Future<List<ProductModel>> getList() async {
    List<ProductModel> products = [
      ProductModel(
          id: 1,
          categoryId: 1,
          price: 126.5,
          preDiscountPrice: 300,
          discountPercentage: '- 12% ',
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          id: 2,
          categoryId: 1,
          price: 126.5,
          preDiscountPrice: 200,
          discountPercentage: '- 12% ',
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png'
      ),
      ProductModel(
          id: 3,
          categoryId: 1,
          price: 126.5,
          preDiscountPrice: 450,
          discountPercentage: '- 12% ',
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          id: 4,
          categoryId: 1,
          price: 126.5,
          preDiscountPrice: 240,
          discountPercentage: '- 12% ',
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png'
      ),
      ProductModel(
          id: 5,
          categoryId: 1,
          price: 126.5,
          preDiscountPrice: 250,
          discountPercentage: '- 12% ',
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png'
      )
    ];
    return products;
  }
}
