import 'package:flutter/material.dart';
import 'package:flutter_restapi/view/drawer/drawer.dart';
import 'package:flutter_restapi/view/products/product_description.dart';
import 'package:flutter_restapi/view/products/product_items.dart';
import 'package:flutter_restapi/view/responsive_layout.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveScreen extends StatelessWidget {
  final p_id;
  ResponsiveScreen({super.key, this.p_id});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => SingleProductProvider(),
      child: Scaffold(
          body: ResponsiveLayout(
              Mobile: ProductItems(),
              Tablet: Row(
                children: [
                  Expanded(flex: 9, child: ProductItems()),
                  Expanded(flex: 9, child: ProductDescription())
                ],
              ),
              Desktop: Row(
                children: [
                  Expanded(
                      flex: _size.width > 1340 ? 3 : 5, child: ProductItems()),
                  Expanded(
                      flex: _size.width > 1340 ? 8 : 10,
                      child: ProductDescription(
                          // product_id: p_id,
                          )),
                  // Expanded(
                  //     flex: _size.width > 1340 ? 8 : 10,
                  //     child: ProductDescription()),
                  Expanded(
                      flex: _size.width > 1340 ? 2 : 4, child: Drawer_View())
                ],
              ))),
    );
  }
}
