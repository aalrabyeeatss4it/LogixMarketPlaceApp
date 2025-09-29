import 'package:get/get.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/features/categories/categories_screen.dart';
import 'package:logix_market_place/features/home/home_screen.dart';
import 'package:logix_market_place/features/home/main_home_screen.dart';
import 'package:logix_market_place/features/profile/profile_screen.dart';

var routePages = [
  GetPage(name: RouteNames.mainHomePage, page: () => MainHomeScreen()),
  GetPage(name: RouteNames.homePage, page: () => HomeScreen()),
  GetPage(name: RouteNames.categoriesPage, page: () => CategoriesScreen()),
  GetPage(name: RouteNames.cartPage, page: () => CartScreen()),
  GetPage(name: RouteNames.profilePage, page: () => ProfileScreen()),
];

class RouteNames {
  static String mainHomePage = '/main-home';
  static String homePage = '/home';
  static String categoriesPage = '/categories';
  static String cartPage = '/cart';
  static String profilePage = '/profile';
}
