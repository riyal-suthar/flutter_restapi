part of 'repository.dart';

class ApiUrls {
  //---- base url for api
  static const String dummyUrl = "https://dummyjson.com/";
  static const String fakeStoreUrl = "https://fakestoreapi.com/";

  static const String _baseUrl = dummyUrl;

  //---- login url
  static const String _loginUrl = "${_baseUrl}auth/login";
  static const String _getUserUrl = "${_baseUrl}users/";

  // String userUrl = "/users/";
  static const String _newUserUrl = "users";

  //----->> fetch api urls <<---//
  static const String _productsUrl = "${_baseUrl}products";
  static const String _searchUrl = "$_productsUrl/search?q=";

  // static const String _sortProductsUrl = "${_baseUrl}products?sortBy=title&order=asc";
  static const String _sortProductsUrl = "${_baseUrl}products?sort=desc";

  static const String _categoriesUrl = "${_baseUrl}products/category-list";
  static const String _productsByCategoryUrl = "${_baseUrl}products/category/";

  //---- fetch use cart list url
  static const String _userCartListUrl = "${_baseUrl}carts/user/";
  static const String _addCartProductUrl = "${_baseUrl}carts/add";
  static const String _cartUpdateDeleteUrl = "${_baseUrl}carts";

  //---- add product for admin
  static const String _addProductUrl = "${_baseUrl}products/add";
}
