import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/models/userCart_model.dart';
import 'package:flutter_restapi/data/services/network_services.dart';
import '../../app_store/shared_preference.dart';
import '../../utils/toastMessage.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  get apiservice => _apiServices;

  // Future<int?> userId = AppStore().getUserToken().then((value) => value.id);

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

  final userId = AppStore().getMyId();

  Future<UserM?> userLogIn(dynamic data) async {
    var response = await _apiServices.postApi(_loginUrl, data);

    try {
      debugPrint("user login ==> ${response.toString()}");
      return response = UserM.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> newUser(dynamic data) async {
    var response = await _apiServices.postApi(_newUserUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateUser(dynamic data) async {
    var response =
        await _apiServices.putApi(_getUserUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> deleteUser() async {
    var response =
        await _apiServices.deleteApi(_getUserUrl + userId.toString());

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> addToCartProduct(dynamic data) async {
    var response = await _apiServices.postApi(_addCartProductUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateCartProduct(dynamic data) async {
    var response = await _apiServices.putApi(
        _cartUpdateDeleteUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> deleteCartList() async {
    var response = await _apiServices.deleteApi(
      _cartUpdateDeleteUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> removeCartProduct() async {
    var response = await _apiServices.deleteApi(
      _cartUpdateDeleteUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCartList?> userCartList() async {
    debugPrint(userId.toString());
    var response = await _apiServices.getApi(_userCartListUrl + "1");

    debugPrint("user cart ==> ${response.toString()}");

    try {
      return response = UserCartList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> addProduct(dynamic data) async {
    var response = await _apiServices.postApi(_addProductUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateProduct(dynamic id, dynamic data) async {
    var response = await _apiServices.putApi(_productsUrl + "/$id", data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<ProductList?> productList() async {
    var response = await _apiServices.getApi(_productsUrl);

    debugPrint("user products ==> ${response.toString()}");
    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> searchProduct(String productName) async {
    var response = await _apiServices.getApi(_searchUrl + productName);

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Products?> singleProductDetails(int id) async {
    var response = await _apiServices.getApi(_productsUrl + "/$id");

    try {
      return response = Products.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<dynamic>?> categoryList() async {
    var response = await _apiServices.getApi(_categoriesUrl);

    debugPrint("user cat ==> ${response.toString()}");

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<ProductList?> productsByCategoryList(String categoryName) async {
    var response =
        await _apiServices.getApi(_productsByCategoryUrl + categoryName);

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
