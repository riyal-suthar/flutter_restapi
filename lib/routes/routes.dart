import 'package:flutter/material.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/view/sec_visual_ui/account_screen.dart';
import 'package:flutter_restapi/view/sec_visual_ui/checkout_screen.dart';
import 'package:flutter_restapi/view/sec_visual_ui/home_screen.dart';
import 'package:flutter_restapi/view/auth/login_screen.dart';
import 'package:flutter_restapi/view/visual_ui/products/cart/cart_items.dart';
import 'package:flutter_restapi/view/visual_ui/products/product_description.dart';
import 'package:flutter_restapi/view/visual_ui/products/product_items.dart';
import 'package:flutter_restapi/view/visual_ui/responsive_screen.dart';
import 'package:flutter_restapi/view/sec_visual_ui/single_product_screen.dart';
import 'package:flutter_restapi/view/splash_screen/splash_screen.dart';
import 'package:flutter_restapi/viewModel/login_provider.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

import '../view/sec_visual_ui/cart_local_screen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.logInScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LogInProvider(),
                child: LoginScreen()));

      case RouteName.accountScreen:
        return MaterialPageRoute(builder: (context) => const AccountScreen());

      case RouteName.homeScreen:
        final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ResponsiveScreen(
            p_id: arg,
          ),
        );

      case RouteName.singleProductScreen:
        final arg = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => ProductDescription(
                  product_id: arg,
                ));

      case RouteName.cartScreen:
        int id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => CartItems(
                  userId: id,
                ));

      case RouteName.checkOutScreen:
        return MaterialPageRoute(builder: (_) => const CheckOutScreen());

      // Second Visuals UI/UX
      case RouteName.secHomeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => Material(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Something went wrong!!"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            },
                            child: const Text("Go to Homepage..."))
                      ]),
                ));
    }
  }
}
