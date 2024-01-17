import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/repository/repository.dart';
import 'package:flutter_restapi/data/services/api_response.dart';
import 'package:flutter_restapi/utils/toastMessage.dart';
import 'package:flutter_restapi/view/products/product_description.dart';

class ProductListProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  ApiResponse<ProductList> productList = ApiResponse.loading();
  setProductList(ApiResponse<ProductList> response) {
    productList = response;
    notifyListeners();
  }

  ApiResponse<List<dynamic>> categoryList = ApiResponse.loading();
  setCategoryList(ApiResponse<List<dynamic>> response) {
    categoryList = response;
    notifyListeners();
  }

  Future<void> fetchCatogoryList() async {
    setCategoryList(ApiResponse.loading());
    _appRepository.categoryList().then((value) {
      setCategoryList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      toastMessage("Something went wrong...!");
      setCategoryList(ApiResponse.error(error.toString()));
      print(error);
    });
  }

  Future<void> fetchCategoryProductList(String categoryName) async {
    if (categoryName.isEmpty || categoryName == null) {
      fetchProductList();
    } else {
      setProductList(ApiResponse.loading());
      _appRepository.categoryProductsList(categoryName).then((value) {
        setProductList(ApiResponse.complete(value));
      }).onError((error, stackTrace) {
        toastMessage("Something went Wrong");
        setProductList(ApiResponse.error(error.toString()));
      });
    }
  }

  Future<void> fetchProductList() async {
    setProductList(ApiResponse.loading());
    _appRepository.productList().then((value) {
      setProductList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      print(productList);
      toastMessage("Something went wrong...!");
      setProductList(ApiResponse.error(error.toString()));
      print(error);
    });
  }

  Future<void> searchProduct(String productName) async {
    if (productName.isEmpty || productName == "") {
      fetchProductList();
    } else {
      setProductList(ApiResponse.loading());
      _appRepository.searchProduct(productName).then((value) {
        setProductList(ApiResponse.complete(value));
      }).onError((error, stackTrace) {
        print(productList);
        toastMessage("Something went wrong...!");
        setProductList(ApiResponse.error(error.toString()));
        print(error);
      });
    }
  }
}

class SingleProductProvider with ChangeNotifier {
  var _imgindex = 0;
  get imgindex => _imgindex;
  setImgIndex(index) {
    _imgindex = index;
    notifyListeners();
  }

  int _id = 1;
  // get id => _id;
  setProductId(int productId) {
    if (_id == productId) {
      return;
    }
    _id = productId;
    notifyListeners();
    // fetchSingleProductDetails();
    // notifyListeners();
  }

  final _appRepository = AppRepository();

  ApiResponse<Products> singleProductDetails = ApiResponse.loading();
  setProductDetails(ApiResponse<Products> response) {
    singleProductDetails = response;
    notifyListeners();
  }

  fetchSingleProductDetails() async {
    int id = _id;
    print("product fetched id : $id");
    setProductDetails(ApiResponse.loading());
    _appRepository.singleProductDetails(id).then((value) {
      setProductDetails(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      toastMessage("Something went wrong");
      setProductDetails(ApiResponse.error(error.toString()));
    });
  }
}
