import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/cart_service.dart';

import '../services/product_service.dart';

class MockProductService implements CartService {
  //
  // Future<List<ProductModel>> getList() async {
  //   List<ProductModel> products = [
  //     ProductModel(
  //         productId: 1,
  //         categoryId: 1,
  //         productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
  //         productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
  //         productThumbPath: 'assets_mock/product1.png'),
  //     ProductModel(
  //         productId: 2,
  //         categoryId: 1,
  //         productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
  //         productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
  //         productThumbPath: 'assets_mock/product2.png')
  //   ];
  //   return products;
  // }

  @override
  Future<void> addItem(CartItemModel item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<void> removeItem(CartItemModel item) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  Future<void> decrementQuantity(CartItemModel item) {
    // TODO: implement decrementQuantity
    throw UnimplementedError();
  }

  @override
  Future<void> incrementQuantity(CartItemModel item) {
    throw UnimplementedError();
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
              productThumbPath: 'assets_mock/product1.png'),
          quantity: 1),
      CartItemModel(
          product: ProductModel(
              productId: 2,
              categoryId: 1,
              productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
              productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
              productThumbPath: 'assets_mock/product2.png'),
          quantity: 1)
    ];
    return items;
  }
}
