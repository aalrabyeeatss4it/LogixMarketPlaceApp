import 'package:logix_market_place/common/storage/local_storage.dart';

const baseUrl = 'https://localhost:44362/api/v1';
// const baseUrl = 'https://api.ecommerce.logix-erp.com/api/v1';
// const baseUrl = 'https://api.ecommerce.qasserlaura.net/api/v1';
const categoriesPath = '/categories';
const announcementsPath = '/announcements';
const productsPath = '/products';
const productsByCategoryPath = '/products/category';
const productsByIdPath = '/products/';
const relatedProductsByIdPath = '/products/related/';
const recentlyArrivedPath = '/products/recently-arrived';
const mostRequestedPath = '/products/most-requested';
const relatedPath = '/products/related/{id}';
const ordersPath = '/orders';
const invoicesPath = '/sale-invoices';
const loginPath = '/users/login';
const addressesPath = '/users/addresses';
const updateAddressPath = '/users/address';
const ssoTokenPath = '/users/sso-token';
const changePasswordPath = '/password/ChangePassword';
const changeEmailPath = '/password/ChangeEmail';

const guestCategoriesPath = '/guest/categories';
const guestProductsPath = '/guest/products';
const guestProductsByIdPath = '/guest/products/';
const guestRelatedProductsByIdPath = '/guest/products/related/';

erpUrl() {
  return "https://www.qasserlaura.net";
  return "http://localhost:8081";
  return "https://erp.ss4it.com.sa";
}

advertisementErpUrl() {
  if (isLoggedIn()) {
    if (box.read(userNameIndex) == 'logixtest@ssit.net.sa') {
      return "https://test.logix-erp.com/";
    }
  }
  return "https://www.qasserlaura.net";
  return "http://localhost:8081";
  return "https://erp.ss4it.com.sa";
}

imagesDirPath() {
  return "/ItemImages/";
}
