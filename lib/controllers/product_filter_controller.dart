import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

class ProductFilter {
  int? page;
  int? category;
  int? minPrice;
  int? maxPrice;
  List<String>? colors;
  List<String>? sizes;

  ProductFilter(
      {
        this.page,
        this.category,
        this.minPrice,
        this.maxPrice,
        this.colors = const [],
        this.sizes = const []}
      );
}

class ProductFilterController extends GetxController {
  RxList<SizeModel> sizes = <SizeModel>[].obs;
  RxList<ColorModel> colors = <ColorModel>[].obs;

  int _page = 1;
  int _category = 0;
  TextEditingController productNameController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  RxList selectedSizeId = [].obs;
  RxList selectedColorId = [].obs;
  RxInt sortBy = 0.obs;

  void resetSort() {
   sortBy.value =0;
  }
  void resetFilters() {
    productNameController.clear();
    minPriceController.clear();
    maxPriceController.clear();
    selectedColorId.clear();
    selectedSizeId.clear();
  }
  String query = "";
  String getQuery() {
    query = "";
    addParam("page", _page.toString());
    if (productNameController.text.isNotEmpty) {
      addParam("name", productNameController.text);
    }
    if (minPriceController.text.isNotEmpty) {
      int? minPrice = int.tryParse(minPriceController.text);
      if (minPrice != null && minPrice>0){
        addParam("min_price", minPriceController.text);
      }
    }
    if (maxPriceController.text.isNotEmpty) {
      int? maxPrice = int.tryParse(maxPriceController.text);
      if (maxPrice != null && maxPrice>0){
        addParam("max_price", maxPriceController.text);
      }
    }
    if (selectedSizeId.isNotEmpty) {
      addParam("sizes", selectedSizeId.join(","));
    }
    if (selectedColorId.isNotEmpty) {
      addParam("colors", selectedColorId.join(","));
    }
    if (_category>0) {
      addParam("category", _category.toString());
    }
    if(sortBy.value>0){
      addParam("sort", getSort);
    }
    return query;
  }
  get getSort {
    if(sortBy.value==1) {
      return "date_desc";
    }
    if(sortBy.value==2) {
      return "date_asc";
    }
    if(sortBy.value==3) {
      return "price_desc";
    }
    if(sortBy.value==4) {
      return "price_asc";
    }
    else {
      return "";
    }

  }

  void addParam(String key, String value) {
    if (value.isEmpty) return;
    if (query.isNotEmpty) {
      query += "&";
    }
    query += "$key=$value";
  }
  Future<void> loadColors() async {
    colors.add(ColorModel(id: 1, colorValue: Colors.red));
    colors.add(ColorModel(id: 2, colorValue: Colors.green));
    colors.add(ColorModel(id: 3, colorValue: Colors.blue));
    colors.add(ColorModel(id: 4, colorValue: Colors.yellow));
  }

  Future<void> loadSizes() async {
    sizes.add(SizeModel(id: 1, name: "S"));
    sizes.add(SizeModel(id: 2, name: "M"));
    sizes.add(SizeModel(id: 3, name: "L"));
    sizes.add(SizeModel(id: 4, name: "XL"));
    sizes.add(SizeModel(id: 5, name: "XXL"));
    sizes.add(SizeModel(id: 6, name: "XXXL"));
  }

  @override
  void onInit() {
    super.onInit();
    loadSizes();
    loadColors();
  }

  void setCategory(int category) {
    _category = category;
  }

  void setPage(int page) {
    _page = page;
  }

}

class SizeModel {
  int id;
  String name;
  RxBool selected = false.obs;

  SizeModel({required this.id, required this.name});
}

class ColorModel {
  int id;
  Color colorValue;
  RxBool selected = false.obs;

  ColorModel({required this.id, required this.colorValue});
}
