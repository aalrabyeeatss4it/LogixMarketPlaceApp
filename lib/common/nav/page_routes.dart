import 'package:get/get.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/features/categories/categories_screen.dart';
import 'package:logix_market_place/features/fav/fav_screen.dart';
import 'package:logix_market_place/features/home/home_screen.dart';
import 'package:logix_market_place/features/product_detail/product_detail_screen.dart';
import 'package:logix_market_place/features/profile/profile_screen.dart';

import '../../features/category_detail/category_detail_screen.dart';

var routePages = [
  GetPage(name: RouteNames.homePage, page: () => HomeScreen()),
  GetPage(name: RouteNames.categoriesPage, page: () => CategoriesScreen()),
  GetPage(name: RouteNames.cartPage, page: () => CartScreen()),
  GetPage(name: RouteNames.profilePage, page: () => ProfileScreen()),
  GetPage(name: RouteNames.categoryDetailPage, page: () => CategoryDetailScreen()),
  GetPage(name: RouteNames.productDetailPage, page: () => ProductDetailScreen()),
  GetPage(name: RouteNames.favPage, page: () => FavScreen()),
];

class RouteNames {
  static String homePage = '/home';
  static String categoriesPage = '/categories';
  static String cartPage = '/cart';
  static String profilePage = '/profile';
  static String categoryDetailPage = '/category-detail';
  static String productDetailPage = '/product-detail';
  static String favPage = '/fav';
}
