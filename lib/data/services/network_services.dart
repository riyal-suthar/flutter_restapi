import 'dart:convert';

import 'package:flutter_restapi/data/services/app_exceptions.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> postApi(String url, dynamic data);

  Future<dynamic> getApi(String url);

  Future<dynamic> putApi(String url, dynamic data);

  Future<dynamic> deleteApi(String url);
}

class NetworkApiServices extends BaseApiServices {
  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        return UnAuthorizedException(message: "Bad request");
      case 401:
        return UnAuthorizedException(message: "Access is not for you");
      default:
        return FetchDataException(message: "Error during communication");
    }
  }

  @override
  Future getApi(String url) async {
    dynamic responseJson;

    try {
      http.Response response = await http.get(Uri.parse(url));
      responseJson = apiResponse(response);
    } catch (e) {
      // throw e.toString();
      print(e.toString());
    }

    return responseJson;
  }

  @override
  Future postApi(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http.post(Uri.parse(url), body: data);
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }

    return responseJson;
  }

  @override
  Future putApi(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http.put(Uri.parse(url), body: data);
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }

    return responseJson;
  }

  @override
  Future deleteApi(String url) async {
    dynamic responseJson;

    try {
      http.Response response = await http.delete(Uri.parse(url));
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }
}
