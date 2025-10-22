import 'package:get/get.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/features/categories/categories_screen.dart';
import 'package:logix_market_place/features/fav/fav_screen.dart';
import 'package:logix_market_place/features/home/home_screen.dart';
import 'package:logix_market_place/features/login/login_screen.dart';
import 'package:logix_market_place/features/orders/orders_screen.dart';
import 'package:logix_market_place/features/product_detail/product_detail_screen.dart';
import 'package:logix_market_place/features/profile/profile_screen.dart';

import '../../features/account_setting/account_setting_screen.dart';
import '../../features/category_detail/category_detail_screen.dart';
import '../../features/checkout/checkout_screen.dart';
import '../../features/new_address/new_address_screen.dart';
import '../../features/order_details/order_details_screen.dart';
import '../../features/order_tracking/order_tracking_screen.dart';

var routePages = [
  GetPage(name: RouteNames.homePage, page: () => const HomeScreen()),
  GetPage(name: RouteNames.categoriesPage, page: () => CategoriesScreen()),
  GetPage(name: RouteNames.cartPage, page: () => CartScreen()),
  GetPage(name: RouteNames.profilePage, page: () => ProfileScreen()),
  GetPage(name: RouteNames.categoryDetailPage, page: () => const CategoryDetailScreen()),
  GetPage(name: RouteNames.productDetailPage, page: () => const ProductDetailScreen()),
  GetPage(name: RouteNames.favPage, page: () => FavScreen()),
  GetPage(name: RouteNames.newAddressPage, page: () => NewAddressScreen()),
  GetPage(name: RouteNames.checkoutPage, page: () => CheckoutScreen()),
  GetPage(name: RouteNames.orderTrackingPage, page: () => OrderTrackingScreen()),
  GetPage(name: RouteNames.loginPage, page: () => LoginScreen()),
  GetPage(name: RouteNames.ordersPage, page: () => const OrdersScreen()),
  GetPage(name: RouteNames.orderDetailsPage, page: () => const OrderDetailsScreen()),
  GetPage(name: RouteNames.accountSettingPage, page: () => AccountSettingScreen()),
];

class RouteNames {
  static String homePage = '/home';
  static String categoriesPage = '/categories';
  static String cartPage = '/cart';
  static String profilePage = '/profile';
  static String categoryDetailPage = '/category-detail';
  static String productDetailPage = '/product-detail';
  static String favPage = '/fav';
  static String newAddressPage = '/new-address';
  static String checkoutPage = '/checkout';
  static String orderTrackingPage = '/order-tracking';
  static String loginPage = '/login';
  static String ordersPage = '/orders';
  static String orderDetailsPage = '/order-details';
  static String accountSettingPage = '/account-setting';
}
