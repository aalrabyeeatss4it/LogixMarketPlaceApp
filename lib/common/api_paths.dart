const baseUrl = 'https://localhost:44362/api/v1';
const categoriesPath = '/categories';
const productsPath = '/products';
const productsByCategoryPath = '/products/category';
const productsByIdPath = '/products/{id}';
const relatedProductsByIdPath = '/products/related/{id}';
const recentlyArrivedPath = '/products/recently-arrived';
const mostRequestedPath = '/products/most-requested';
const relatedPath = '/products/related/{id}';
const newOrderPath = '/orders';
const loginPath = '/users/login';

erpUrl(){
  return "http://localhost:8081";
  return "https://erp.ss4it.com.sa";
  return "https://test.logix-erp.com";
}
imagesDirPath(){
  return "/ItemImages/";
}
