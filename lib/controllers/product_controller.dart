import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/product_filter_controller.dart';
import 'package:logix_market_place/services/product_service.dart';
import '../common/storage/local_storage.dart';
import '../models/product_model.dart';
import 'login_controller.dart';


class ProductController extends GetxController {
  var isCategoryLoading = false.obs;
  var isMostRequestedLoading = false.obs;
  var isLoading = false.obs;
  int page = 1;
  int categoryProductsPage = 1;
  bool hasMore = true;
  bool hasMoreCategoryProducts = true;
  ScrollController scroll = ScrollController();
  ScrollController categoryProductScroll = ScrollController();

  RxList<ProductModel> recentlyArrivedProducts = <ProductModel>[].obs;
  RxList<ProductModel> mostRequestedProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  ProductService productService = Get.put(ProductService());

  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getRecentlyArrived();
      }
    });
  }

  Future<void> getRecentlyArrived() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    Get.find<ProductFilterController>().setCategory(0);
    Get.find<ProductFilterController>().setPage(page);
    var filters = Get.find<ProductFilterController>().getQuery();
    try {
      var result = (checkLoggedIn())? await productService.getRecentlyArrived(filters): await productService.getGuestProducts(filters);
      if(result.isEmpty){
        hasMore = false;
      }
      else{
        recentlyArrivedProducts.addAll(result);
        page++;
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> getMostRequested() async {
    isMostRequestedLoading.value = true;
    mostRequestedProducts.clear();
    try {
      var result = await productService.getMostRequested();
      mostRequestedProducts.assignAll(result);
    }
    catch(ex){
      isMostRequestedLoading.value = false;
    }
    finally {
      isMostRequestedLoading.value = false;
    }
  }

  Future<void> resetCategoryPagination() async {
    categoryProductsPage = 1;
    hasMoreCategoryProducts = true;
    categoryProducts.clear();
  }

  Future<void> resetPagination() async {
    page = 1;
    hasMore = true;
    recentlyArrivedProducts.clear();
  }
  Future<void> getByCategory(int categoryId) async {
    print("getByCategory");
    if(isCategoryLoading.value || !hasMoreCategoryProducts) return;
    isCategoryLoading.value = true;
    Get.find<ProductFilterController>().setCategory(categoryId);
    Get.find<ProductFilterController>().setPage(categoryProductsPage);
    var filters = Get.find<ProductFilterController>().getQuery();
    try {
      var result =  (checkLoggedIn())? await productService.getRecentlyArrived(filters): await productService.getGuestProducts(filters);
      if(result.isEmpty){
        hasMoreCategoryProducts = false;
      }
      else{
        categoryProducts.addAll(result);
        categoryProductsPage++;
      }
    }
    catch(ex){
      isCategoryLoading.value = false;
    }
    finally {
      isCategoryLoading.value = false;
    }
  }
}
