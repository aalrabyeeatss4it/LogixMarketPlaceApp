import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/product_detail_service.dart';

import '../services/product_service.dart';

class MockProductDetailService implements ProductDetailService {
  @override
  Future<ProductModel?> getProduct(int productID) async {
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
        productId: 1,
        categoryId: 1,
        productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع',
        productDesc:
            'تصميم عصري أنيق ومقاوم للصدأ مصنوع من خامات عالية الجودة لمقاومة الصدأ والتآكل، مع طبقة تشطيب ذهبية تحافظ على اللمعان لفترة طويلة. التصميم العصري بخطوطه المستقيمة يضيف لمسة جمالية راقية تناسب الحمامات الحديثة والكلاسيكية على حد سواء.',
        productThumbPath: 'assets_mock/product1.png',
        attributes: att);
    return product;
  }
  @override
  Future<List<ProductModel>> getRelatedProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<ProductModel> products = [
      ProductModel(
          productId: 1,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productDesc: 'خلّاط مغسلة مرتفع فاخر باللون الذهبي اللامع – تصميم عصري أنيق ومقاوم للصدأ ..',
          productThumbPath: 'assets_mock/product1.png'),
      ProductModel(
          productId: 2,
          categoryId: 1,
          productName: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productDesc: 'خلّاط مغسلة مرتفع – أسود مطفي',
          productThumbPath: 'assets_mock/product2.png')
    ];
    return products;
  }
}
