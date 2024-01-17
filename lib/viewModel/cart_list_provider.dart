import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/data/models/userCart_model.dart';
import 'package:flutter_restapi/data/repository/repository.dart';
import 'package:flutter_restapi/data/services/api_response.dart';

import '../data/models/product_model.dart';
import '../utils/toastMessage.dart';

List _cartList = [];
get cartList => _cartList;

class CartListProvider with ChangeNotifier {
  //----- Cart list in local
  addToLocalCart(Products? cartProduct, int qty) {
    List addcart = [cartProduct, qty];
    _cartList.add(addcart);
    print(_cartList.length);
    notifyListeners();
  }

  removeFromLocalCart(int index) {
    _cartList.removeAt(index);
    notifyListeners();
  }

  updateLocalQty(index, int qty) {
    _cartList[index][1] = qty;
    notifyListeners();
  }

  num totalLocalPrice() {
    num totalPrice = 0.0;
    for (var item in _cartList) {
      totalPrice += item[0].price * item[1];
    }
    return totalPrice;
  }

  //----- Cart list from RestApi
  AppRepository _appRepository = AppRepository();
  // var _app = _appRepository.userCartList(id);

  ApiResponse<UserCartList?> userCartList = ApiResponse.loading();
  setUserCartList(ApiResponse<UserCartList?> response) {
    userCartList = response;
    notifyListeners();
  }

  Future<void> userCart() async {
    setUserCartList(ApiResponse.loading());
    _appRepository
        .userCartList()
        .then((value) => setUserCartList(ApiResponse.complete(value)))
        .onError((error, stackTrace) {
      toastMessage("Something went Wrong");
      setUserCartList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addToCart(dynamic data) async {
    setUserCartList(ApiResponse.loading());
    _appRepository.addToCartProduct(data).then((value) {
      toastMessage(value.toString() + "\nproduct added to cart successfully.");
    }).onError((error, stackTrace) => toastMessage("something went wrong"));
  }

  Future<void> updateCart(dynamic data) async {
    setUserCartList(ApiResponse.loading());
    _appRepository.updateCartProduct(data).then((value) {
      toastMessage(value.toString() + "\nproduct added to cart successfully.");
    }).onError((error, stackTrace) => toastMessage("something went wrong"));
  }

  Future<void> removeCartList() async {
    setUserCartList(ApiResponse.loading());
    _appRepository.deleteCartList().then((value) {
      toastMessage("Cart products deleted successfully.");
    }).onError((error, stackTrace) => toastMessage("something went wrong"));
  }

  Future<void> removeCartProduct(dynamic data) async {
    setUserCartList(ApiResponse.loading());
    _appRepository.deleteCartList().then((value) {
      toastMessage("Cart removed successfully.");
    }).onError((error, stackTrace) => toastMessage("something went wrong"));
  }
}
