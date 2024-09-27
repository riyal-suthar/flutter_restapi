import 'package:flutter/material.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/utils/toastMessage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _getToken() {
    String? token;
    AppStore().getUserToken().then((value) {
      user = value;

      debugPrint("userToken: ${value.accessToken}");
      debugPrint("user : ${value.toJson()}");
      token = value.accessToken;
    });
    return token;
  }

  @override
  void initState() {
    super.initState();
    String? token = _getToken();
    Future.delayed(const Duration(seconds: 4), () {
      if (token == "" || token == null) {
        Navigator.pushReplacementNamed(context, RouteName.logInScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("splashscreen is visited");
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 3),
              builder: (context, val, _) {
                return Opacity(
                    opacity: val,
                    child: Image.asset(ImageAssets.instance.appLogo));
              },
            ),
          ),
        ],
      ),
    );
  }
}
