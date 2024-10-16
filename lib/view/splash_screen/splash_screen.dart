import 'package:flutter/material.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/viewModel/services/auth_check_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthCheckServices().checkAuthentication(context);
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
