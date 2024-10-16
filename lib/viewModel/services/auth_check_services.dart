import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/routes/routes_name.dart';

class AuthCheckServices {
  Future<UserM> getUserData() => AppStore().getUserToken();

  void checkAuthentication(BuildContext context) {
    getUserData().then((value) async {
      await Future.delayed(const Duration(seconds: 4), () {
        debugPrint("get token is => ${value.accessToken}");
        if (value.accessToken == "" ||
            value.accessToken == null ||
            value.accessToken!.isEmpty) {
          Navigator.pushReplacementNamed(context, RouteName.logInScreen);
        } else {
          Navigator.pushReplacementNamed(context, RouteName.homeScreen);
        }
      });
    }).onError((e, s) {
      debugPrint(e.toString());
    });
  }
}
