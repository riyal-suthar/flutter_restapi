import 'package:flutter/material.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/view/account_screen.dart';
import 'package:flutter_restapi/view/checkout_screen.dart';
import 'package:flutter_restapi/view/home_screen.dart';
import 'package:flutter_restapi/view/login_screen.dart';
import 'package:flutter_restapi/view/products/cart/cart_items.dart';
import 'package:flutter_restapi/view/products/product_description.dart';
import 'package:flutter_restapi/view/products/product_items.dart';
import 'package:flutter_restapi/view/responsive_screen.dart';
import 'package:flutter_restapi/view/single_product_screen.dart';
import 'package:flutter_restapi/view/splash_screen.dart';
import 'package:flutter_restapi/viewModel/login_provider.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

import '../view/cart_local_screen.dart';

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
        return MaterialPageRoute(builder: (context) => const CartItems());

      case RouteName.checkOutScreen:
        return MaterialPageRoute(builder: (_) => const CheckOutScreen());

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
