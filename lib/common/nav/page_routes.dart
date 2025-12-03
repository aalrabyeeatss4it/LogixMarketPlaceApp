import 'package:get/get.dart';
import 'package:logix_market_place/features/availability_order/availability_order_screen.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/features/categories/categories_screen.dart';
import 'package:logix_market_place/features/change_email/change_email_screen.dart';
import 'package:logix_market_place/features/change_lang/change_lang_screen.dart';
import 'package:logix_market_place/features/change_password/change_password_screen.dart';
import 'package:logix_market_place/features/home/home_screen.dart';
import 'package:logix_market_place/features/login/login_screen.dart';
import 'package:logix_market_place/features/payment_methods/payment_methods_screen.dart';
import 'package:logix_market_place/features/product_detail/product_detail_screen.dart';
import 'package:logix_market_place/features/profile/profile_screen.dart';

import '../../features/account_info/account_info_screen.dart';
import '../../features/account_setting/account_setting_screen.dart';
import '../../features/category_detail/category_detail_screen.dart';
import '../../features/checkout/checkout_screen.dart';
import '../../features/edit_address/edit_address_screen.dart';
import '../../features/google_pay/google_pay_screen.dart';
import '../../features/guest_home/guest_home_screen.dart';
import '../../features/invoice_details/invoice_details_screen.dart';
import '../../features/my_delivery_address/delivery_address_screen.dart';
import '../../features/my_fav/fav_screen.dart';
import '../../features/my_invoices/invoices_screen.dart';
import '../../features/my_orders/orders_screen.dart';
import '../../features/new_address/new_address_screen.dart';
import '../../features/order_details/order_details_screen.dart';
import '../../features/order_tracking/order_tracking_screen.dart';

var routePages = [
  GetPage(name: RouteNames.homePage, page: () => const HomeScreen()),
  GetPage(name: RouteNames.guestHomePage, page: () => const GuestHomeScreen()),
  GetPage(name: RouteNames.categoriesPage, page: () => CategoriesScreen()),
  GetPage(name: RouteNames.cartPage, page: () => CartScreen()),
  GetPage(name: RouteNames.profilePage, page: () => ProfileScreen()),
  GetPage(name: RouteNames.categoryDetailPage, page: () => const CategoryDetailScreen()),
  GetPage(name: RouteNames.productDetailPage, page: () => const ProductDetailScreen()),
  GetPage(name: RouteNames.favPage, page: () => FavScreen()),
  GetPage(name: RouteNames.newAddressPage, page: () => NewAddressScreen()),
  GetPage(name: RouteNames.editAddressPage, page: () => const EditAddressScreen()),
  GetPage(name: RouteNames.checkoutPage, page: () => CheckoutScreen()),
  GetPage(name: RouteNames.orderTrackingPage, page: () => OrderTrackingScreen()),
  GetPage(name: RouteNames.loginPage, page: () => LoginScreen()),
  GetPage(name: RouteNames.ordersPage, page: () => const OrdersScreen()),
  GetPage(name: RouteNames.orderDetailsPage, page: () => const OrderDetailsScreen()),
  GetPage(name: RouteNames.accountSettingPage, page: () => AccountSettingScreen()),
  GetPage(name: RouteNames.accountInfoPage, page: () => const AccountInfoScreen()),
  GetPage(name: RouteNames.changeEmailPage, page: () => ChangeEmailScreen()),
  GetPage(name: RouteNames.changePasswordPage, page: () => ChangePasswordScreen()),
  GetPage(name: RouteNames.changeLangPage, page: () => ChangeLangScreen()),
  GetPage(name: RouteNames.deliveryAddressPage, page: () => DeliveryAddressScreen()),
  GetPage(name: RouteNames.paymentMethodsPage, page: () => PaymentMethodsScreen()),
  GetPage(name: RouteNames.availabilityOrderPage, page: () => AvailabilityOrderScreen()),
  GetPage(name: RouteNames.invoicesPage, page: () => const InvoicesScreen()),
  GetPage(name: RouteNames.invoiceDetailsPage, page: () => const InvoiceDetailsScreen()),
  GetPage(name: RouteNames.googlePayPage, page: () => const GooglePayScreen()),
];

class RouteNames {
  static String homePage = '/home';
  static String guestHomePage = '/guest-home';
  static String categoriesPage = '/categories';
  static String cartPage = '/cart';
  static String profilePage = '/profile';
  static String categoryDetailPage = '/category-detail';
  static String productDetailPage = '/product-detail';
  static String favPage = '/fav';
  static String newAddressPage = '/new-address';
  static String editAddressPage = '/edit-address';
  static String checkoutPage = '/checkout';
  static String orderTrackingPage = '/order-tracking';
  static String loginPage = '/login';
  static String ordersPage = '/orders';
  static String orderDetailsPage = '/order-details';
  static String invoiceDetailsPage = '/invoice-details';
  static String accountSettingPage = '/account-setting';
  static String accountInfoPage = '/account-info';
  static String changeEmailPage = '/change-email';
  static String changePasswordPage = '/change-password';
  static String changeLangPage = '/change-lang';
  static String deliveryAddressPage = '/delivery-address';
  static String paymentMethodsPage = '/payment-methods';
  static String availabilityOrderPage = '/availability-orders';
  static String invoicesPage = '/invoices';
  static String googlePayPage = '/google_pay';
}
