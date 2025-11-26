import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../controllers/product_controller.dart';
import '../product_filter/product_filter_widget.dart';
import '../product_filter/product_sort_widget.dart';
import 'category_product_card.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final ProductController productController = Get.put(ProductController());
  late final int categoryId;
  late final String categoryName;
  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    categoryId = args['categoryId'];
    categoryName = args['categoryName'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getByCategory(categoryId);
    });
    productController.categoryProductScroll.addListener(() {
      if (productController.categoryProductScroll.position.pixels == productController.categoryProductScroll.position.maxScrollExtent) {
        print("productController.categoryProductScroll.addListener");
        productController.getByCategory(categoryId);
      }
    });
  }

  void openFilters() {
    Get.bottomSheet(
      ProductFilterWidget(
          onApplyFilters: (){
            productController.resetCategoryPagination();
            productController.getByCategory(categoryId);
            Get.back();
            Get.focusScope?.unfocus();
          }),
      isScrollControlled: true,
    );
  }

  void openSorts() {
    Get.bottomSheet(
      ProductSortWidget(
          onApplySort: (){
            productController.getByCategory(categoryId);
            Get.back();
            Get.focusScope?.unfocus();
          }),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            title: "home",
            onApplyFilters: (){
              productController.getByCategory(categoryId);
              Get.back();
              Get.focusScope?.unfocus();
            }
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(categoryName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    softWrap: true,
                  )),
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            openSorts();
                          },
                          child: Image.asset('icons/sort.png',width: 30,height: 30,)
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            openFilters();
                          },
                          child: Image.asset('icons/filter.png',width: 30,height: 30,)
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (productController.isCategoryLoading.value  && productController.categoryProductsPage==1) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (productController.categoryProducts.isEmpty) {
                  return const Center(child: Text("No products"));
                }
                return ListView.builder(
                    controller: productController.categoryProductScroll,
                    padding: const EdgeInsets.all(8),
                    itemCount: productController.categoryProducts.length+1,
                    itemBuilder: (BuildContext context, int index) {
                      if(index < productController.categoryProducts.length){
                        return CategoryProductCard(product: productController.categoryProducts[index]);
                      }
                      else{
                        return productController.hasMoreCategoryProducts?
                        const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator())
                        ): const SizedBox();
                      }

                    });
              }),
            ),
          ],
        ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 1,),
    );
  }
}
