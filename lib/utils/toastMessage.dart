import 'package:flutter/material.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}

// final userId = AppStore().getUserToken().then((value) {
//   debugPrint(value.id.toString());
//   return value.id;
// });

// UserM? user;
