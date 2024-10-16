import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
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
        throw UnAuthorizedException(response.body.toString());
      case 401:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with status code ${response.statusCode}');
    }
  }

  @override
  Future getApi(String url) async {
    dynamic responseJson;

    try {
      http.Response response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      responseJson = apiResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return responseJson;
  }

  @override
  Future postApi(String url, dynamic data) async {
    dynamic responseJson;

    try {
      http.Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 30));
      responseJson = apiResponse(response);
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
    }
    return responseJson;
  }
}
