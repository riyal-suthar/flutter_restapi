import 'package:flutter/material.dart';
import 'package:flutter_restapi/view/drawer/drawer.dart';
import 'package:flutter_restapi/view/products/product_description.dart';
import 'package:flutter_restapi/view/products/product_item.dart';
import 'package:provider/provider.dart';

import '../../data/services/api_response.dart';
import '../../routes/routes_name.dart';
import '../../viewModel/product_list_provider.dart';
import '../responsive_layout.dart';

class ProductItems extends StatefulWidget {
  const ProductItems({super.key});

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductListProvider productListProvider = ProductListProvider();
  SingleProductProvider singleProductProvider = SingleProductProvider();

  @override
  void initState() {
    productListProvider.fetchProductList();
    productListProvider.fetchCatogoryList();
    super.initState();
  }

  String? _selected;
  TextEditingController search = TextEditingController();
  var _selectedItem;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => productListProvider),
        ChangeNotifierProvider(
            create: (BuildContext context) => singleProductProvider),
      ],
      child: Consumer2<ProductListProvider, SingleProductProvider>(
          builder: (context, value, val, _) {
        print(_selectedItem);
        switch (value.productList.status) {
          case Status.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case Status.error:
            return Center(
              child: Text(value.productList.message.toString()),
            );
          case Status.complete:
            return Scaffold(
              key: _scaffoldKey,
              endDrawer: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Drawer_View()),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: search,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                hintText: "Search....",
                                suffixIcon: Icon(Icons.search),
                              ),
                              onFieldSubmitted: (productName) {
                                productListProvider.searchProduct(productName);
                              },
                            ),
                          ),
                          if (!ResponsiveLayout.isDesktop(context))
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.categoryList.data!.length,
                          itemBuilder: (context, index) {
                            var x = value.categoryList.data![index].toString();
                            final choice = x;
                            return Padding(
                                padding: EdgeInsets.all(8),
                                child: ChoiceChip.elevated(
                                  label: Text(
                                    x,
                                    style: TextStyle(),
                                  ),
                                  iconTheme: IconThemeData(),
                                  selected: _selected == choice,
                                  onSelected: (val) {
                                    productListProvider
                                        .fetchCategoryProductList(x);
                                    if (_selected == choice) {
                                      _selected = null;
                                      productListProvider.fetchProductList();
                                    } else {
                                      _selected = choice;
                                    }
                                  },
                                  selectedColor: Colors.indigoAccent.shade100,
                                ));
                          }),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GridView.builder(
                        primary: true,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: value.productList.data!.products!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          var data = value.productList.data!.products![index];
                          if (data == null) {
                            return Container(
                              height: 100,
                              width: 100,
                              color: Colors.black,
                            );
                          } else {
                            return ProductItem(
                              item: data,
                              onPressed: () {
                                int product_id = data.id!;

                                _selectedItem = index;

                                if (ResponsiveLayout.isMobile(context)) {
                                  Navigator.pushNamed(
                                      context, RouteName.singleProductScreen,
                                      arguments: product_id);
                                } else {
                                  //-----all ui is refreshed-------//

                                  // Navigator.pushNamed(
                                  //     context, RouteName.homeScreen,
                                  //     arguments: product_id);

                                  //------with provider-------//
                                  // print("with provider");
                                  // val.setProductId(product_id);
                                  // val.setIsChanged(true);
                                  val.fetchSingleProductDetails(product_id);
                                  print("object");
                                }
                              },
                              selected: ResponsiveLayout.isMobile(context)
                                  ? false
                                  : index == _selectedItem,
                            );
                          }
                        }),
                  ],
                ),
              ),
            );
          default:
            return Container(
              color: Colors.indigoAccent,
            );
        }
      }),
    );
  }
}
