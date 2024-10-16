import 'package:flutter/material.dart';
import 'package:flutter_restapi/view/visual_ui/drawer/drawer.dart';
import 'package:flutter_restapi/view/sec_visual_ui/single_product_screen.dart';
import 'package:flutter_restapi/view/visual_ui/products/product_item.dart';
import 'package:provider/provider.dart';
import '../../../data/services/api_response.dart';
import '../../../viewModel/product_list_provider.dart';
import '../../responsive_layout/responsive_layout.dart';

class ProductItems extends StatefulWidget {
  const ProductItems({super.key});

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

ValueNotifier<int> idIs = ValueNotifier(1);

class _ProductItemsState extends State<ProductItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductListProvider productListProvider = ProductListProvider();
  SingleProductProvider singleProductProvider = SingleProductProvider();

  @override
  void initState() {
    productListProvider.fetchProductList();
    productListProvider.fetchCategoryList();
    super.initState();
  }

  String? _selected;
  var _selectedItem;
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => productListProvider),
        ChangeNotifierProvider(create: (context) => singleProductProvider),
      ],
      child: Consumer<ProductListProvider>(builder: (context, prodlist, _) {
        switch (prodlist.productList.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.error:
            return Center(child: Text(prodlist.productList.message.toString()));
          case Status.complete:
            return Scaffold(
              key: _scaffoldKey,
              endDrawer: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
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
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                hintText: "Search....",
                                suffixIcon: Icon(Icons.search),
                              ),
                              onFieldSubmitted: (productName) {
                                prodlist.searchProduct(productName);
                              },
                            ),
                          ),
                          if (!ResponsiveLayout.isDesktop(context))
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (prodlist.categoryList.data == null ||
                        prodlist.categoryList.data!.isEmpty)
                      LinearProgressIndicator()
                    else
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: prodlist.categoryList.data!.length,
                            itemBuilder: (context, index) {
                              var x =
                                  prodlist.categoryList.data![index].toString();
                              final choice = x;
                              return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ChoiceChip.elevated(
                                    label: Text(
                                      x,
                                      style: const TextStyle(),
                                    ),
                                    iconTheme: const IconThemeData(),
                                    selected: _selected == choice,
                                    onSelected: (val) {
                                      prodlist.fetchCategoryProductList(x);
                                      if (_selected == choice) {
                                        _selected = null;
                                        prodlist.fetchProductList();
                                      } else {
                                        _selected = choice;
                                      }
                                    },
                                    selectedColor: Colors.indigoAccent.shade100,
                                  ));
                            }),
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    GridView.builder(
                        primary: true,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: prodlist.productList.data!.products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          var data =
                              prodlist.productList.data!.products![index];
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

                                if (ResponsiveLayout.isMobile(context)) {
                                  // Navigator.pushNamed(
                                  //     context, RouteName.singleProductScreen,
                                  //     arguments: product_id);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Single_Product_Screen(
                                                  product_id: product_id)));
                                } else {
                                  _selectedItem = index;
                                  //-----all ui is refreshed-------//

                                  // Navigator.pushNamed(
                                  //     context, RouteName.homeScreen,
                                  //     arguments: product_id);

                                  //------with provider-------//
                                  print("with provider");

                                  idIs.value = product_id;
                                  // singleProductProvider
                                  //     .fetchSingleProductDetails(product_id);
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
