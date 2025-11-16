import 'package:get_storage/src/storage_impl.dart';
import 'package:http/src/response.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/product_detail_service.dart';

import '../services/product_service.dart';

class MockProductDetailService implements ProductDetailService {
  @override
  Future<ProductModel?> getProduct(int productID, int qty) async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<Attribute> att = [
      Attribute(label: ' المقاس', value: '18 × 28 سم'),
      Attribute(label: ' اللون', value: 'ذهبي لامع'),
      Attribute(label: ' الخامة', value: '18خامة متينة مقاومة للصدأ والرطوبة'),
      Attribute(label: ' اخرى', value: 'سهل التركيب والتنظيف'),
      Attribute(label: 'تصميم مرتفع مخصص لأحواض المغاسل الحديثة'),
      Attribute(label: ' لمسة فاخرة تعكس الأناقة في ديكور الحمام'),
      Attribute(label: ' تشطيب ذهبي مقاوم للبقع والتقشير'),
      Attribute(label: ' مناسب للاستخدام اليومي المكثف'),
    ];
    ProductModel product = ProductModel(
        id: productID,
        categoryId: 1,
        basePrice: 6.5,
        vat: 15,
        unitId: 15,
        // preDiscountPrice: 500,
        discountPercentage: 12,
        name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع',
        desc:
            'تصميم عصري أنيق ومقاوم للصدأ مصنوع من خامات عالية الجودة لمقاومة الصدأ والتآكل، مع طبقة تشطيب ذهبية تحافظ على اللمعان لفترة طويلة. التصميم العصري بخطوطه المستقيمة يضيف لمسة جمالية راقية تناسب الحمامات الحديثة والكلاسيكية على حد سواء.',
        thumbPath: 'assets_mock/product1.png',
        attributes: att, inventoryBalance: 0);
    return product;
  }
  @override
  Future<List<ProductModel>> getRelatedProducts(int productID,) async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<ProductModel> products = [
      ProductModel(
          id: 1,
          categoryId: 1,
          basePrice: 6.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 500,
          discountPercentage: 12,
          name: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          desc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          thumbPath: 'assets_mock/product1.png', inventoryBalance: 0),
      ProductModel(
          id: 2,
          categoryId: 1,
          basePrice: 6.5,
          vat: 15,
          unitId: 15,
          // preDiscountPrice: 300,
          discountPercentage: 12,
          name: 'خلّاط مغسلة مرتفع – أسود مطفي',
          desc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          thumbPath: 'assets_mock/product2.png', inventoryBalance: 0)
    ];
    return products;
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
}
