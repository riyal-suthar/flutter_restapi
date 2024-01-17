import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/models/userCart_model.dart';
import 'package:flutter_restapi/data/services/network_services.dart';

import '../../utils/toastMessage.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  get apiservice => _apiServices;

  int? userId = user!.id;

  //---- base url for api
  String baseUrl = "https://dummyjson.com";

  //---- login url
  String loginUrl = "/auth/login";
  String userUrl = "/users/";
  String newUserUrl = "/users/add";

  //----->> fetch api urls <<---//
  String productsUrl = "/products";
  String searchUrl = "/search?q=";
  String categoriesUrl = "/products/categories";
  String categoryProductsUrl = "/products/category/";

  //---- fetch use cart list url
  String userCartListUrl = "/carts/user/";
  String userCartUpdateUrl = "/carts/";
  String addCartProductUrl = "/carts/add";

  //---- add product for admin
  String addProductUrl = "/products/add";

  Future<LoginUser?> userLogIn(dynamic data) async {
    var response = await _apiServices.postApi(baseUrl + loginUrl, data);

    try {
      return response = LoginUser.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> newUser(dynamic data) async {
    var response = await _apiServices.postApi(baseUrl + newUserUrl, data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateUser(dynamic data) async {
    var response =
        await _apiServices.putApi(baseUrl + userUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteUser() async {
    var response =
        await _apiServices.deleteApi(baseUrl + userUrl + userId.toString());

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> addToCartProduct(dynamic data) async {
    var response =
        await _apiServices.postApi(baseUrl + addCartProductUrl, data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateCartProduct(dynamic data) async {
    var response = await _apiServices.putApi(
        baseUrl + userCartUpdateUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteCartList() async {
    var response = await _apiServices.deleteApi(
      baseUrl + userCartUpdateUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> removeCartProduct() async {
    var response = await _apiServices.deleteApi(
      baseUrl + userCartUpdateUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCartList?> userCartList() async {
    print(userId);
    var response = await _apiServices
        .getApi(baseUrl + userCartListUrl + userId.toString());

    try {
      return response = UserCartList.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> addProduct(dynamic data) async {
    var response = await _apiServices.postApi(baseUrl + addProductUrl, data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateProduct(dynamic id, dynamic data) async {
    var response =
        await _apiServices.putApi(baseUrl + productsUrl + "/$id", data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProductList?> productList() async {
    var response = await _apiServices.getApi(baseUrl + productsUrl);
    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> searchProduct(String productName) async {
    var response = await _apiServices
        .getApi(baseUrl + productsUrl + searchUrl + "$productName");

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> singleProductDetails(int id) async {
    var response = await _apiServices.getApi(baseUrl + productsUrl + "/$id");

    try {
      return response = Products.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<dynamic?>?> categoryList() async {
    var response = await _apiServices.getApi(baseUrl + categoriesUrl);
    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProductList?> categoryProductsList(String categoryName) async {
    var response =
        await _apiServices.getApi(baseUrl + categoryProductsUrl + categoryName);

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
  }
}
