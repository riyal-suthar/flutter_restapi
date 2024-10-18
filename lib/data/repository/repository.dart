import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/models/userCart_model.dart';
import 'package:flutter_restapi/data/services/network_services.dart';
import '../../app_store/shared_preference.dart';
import '../../utils/toastMessage.dart';

part 'api_urls.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  get apiservice => _apiServices;

  // Future<int?> userId = AppStore().getUserToken().then((value) => value.id);
  // final userId = 1;

  Future<UserM?> userLogIn(dynamic data) async {
    var response = await _apiServices.postApi(ApiUrls._loginUrl, data);

    try {
      debugPrint("user login ==> ${response.toString()}");
      return response = UserM.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> newUser(dynamic data) async {
    var response = await _apiServices.postApi(ApiUrls._newUserUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateUser(dynamic data, userId) async {
    var response = await _apiServices.putApi(
        ApiUrls._getUserUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> deleteUser(userId) async {
    var response =
        await _apiServices.deleteApi(ApiUrls._getUserUrl + userId.toString());

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> addToCartProduct(dynamic data) async {
    var response = await _apiServices.postApi(ApiUrls._addCartProductUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateCartProduct(dynamic data, userId) async {
    var response = await _apiServices.putApi(
        ApiUrls._cartUpdateDeleteUrl + userId.toString(), data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> deleteCartList(userId) async {
    var response = await _apiServices.deleteApi(
      ApiUrls._cartUpdateDeleteUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> removeCartProduct(userId) async {
    var response = await _apiServices.deleteApi(
      ApiUrls._cartUpdateDeleteUrl + userId.toString(),
    );

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCartList?> userCartList(userId) async {
    debugPrint(userId.toString());
    var response =
        await _apiServices.getApi(ApiUrls._userCartListUrl + userId.toString());

    debugPrint("user cart ==> ${response.toString()}");

    try {
      return response = UserCartList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> addProduct(dynamic data) async {
    var response = await _apiServices.postApi(ApiUrls._addProductUrl, data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> updateProduct(dynamic id, dynamic data) async {
    var response =
        await _apiServices.putApi("${ApiUrls._productsUrl}/$id", data);

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<ProductList?> productList() async {
    var response = await _apiServices.getApi(ApiUrls._productsUrl);

    debugPrint("user products ==> ${response.toString()}");
    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> searchProduct(String productName) async {
    var response = await _apiServices.getApi(ApiUrls._searchUrl + productName);

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Products?> singleProductDetails(int id) async {
    var response = await _apiServices.getApi("${ApiUrls._productsUrl}/$id");

    try {
      return response = Products.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<dynamic>?> categoryList() async {
    var response = await _apiServices.getApi(ApiUrls._categoriesUrl);

    debugPrint("user cat ==> ${response.toString()}");

    try {
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<ProductList?> productsByCategoryList(String categoryName) async {
    var response = await _apiServices
        .getApi(ApiUrls._productsByCategoryUrl + categoryName);

    try {
      return response = ProductList.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
