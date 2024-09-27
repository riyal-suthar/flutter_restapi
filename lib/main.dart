import 'package:flutter/material.dart';
import 'package:flutter_restapi/routes/routes.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/viewModel/cart_list_provider.dart';
import 'package:flutter_restapi/viewModel/login_provider.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LogInProvider()),
    ChangeNotifierProvider(create: (context) => ProductListProvider()),
    ChangeNotifierProvider(create: (context) => SingleProductProvider()),
    ChangeNotifierProvider(create: (context) => CartListProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
      // home: SplashScreen(),
    );
  }
}
