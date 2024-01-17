import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/services/api_response.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductListProvider productListProvider = ProductListProvider();

  @override
  void initState() {
    productListProvider.fetchProductList();
    productListProvider.fetchCatogoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => productListProvider,
        child: Consumer<ProductListProvider>(builder: (context, value, _) {
          TextEditingController search = TextEditingController();
          bool isSelected = false;
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
                // drawer: (isMobile(context)) ? Drawer() : Container(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: search,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54)),
                            hintText: "Search....",
                            suffixIcon: Icon(Icons.search),
                          ),
                          onFieldSubmitted: (productName) {
                            productListProvider.searchProduct(productName);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.categoryList.data!.length,
                            itemBuilder: (context, index) {
                              var x =
                                  value.categoryList.data![index].toString();

                              return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ChoiceChip.elevated(
                                    label: Text(x),
                                    selected: isSelected,
                                    onSelected: (val) {
                                      productListProvider
                                          .fetchCategoryProductList(x);
                                      setState(() {
                                        isSelected = val;
                                      });
                                    },
                                    selectedColor: Colors.indigoAccent,
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      buildLayoutBuilder(value),
                    ],
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        }));
  }

  LayoutBuilder buildLayoutBuilder(
    ProductListProvider value,
  ) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constarint) {
      if (constarint.maxWidth > 650) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: constarint.maxWidth > 600 ? 7 : 9,
                child: DesktopScreen(value)),
            // Expanded(
            //     flex: constarint.maxWidth > 1100 ? 3 : 0, child: DrawerView())
          ],
        );
      } else {
        return MobileScreen(value);
      }
    });
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  ListView MobileScreen(ProductListProvider value) {
    return ListView.builder(
        itemCount: value.productList.data!.products!.length,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) {
          var data = value.productList.data!.products![index];
          return InkWell(
            onTap: () {
              int? product_id = data.id;
              Navigator.pushNamed(context, RouteName.singleProductScreen,
                  arguments: product_id);
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              color: Colors.grey.shade300,
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.transparent,
                        child: Image.network(
                          data.thumbnail.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: Container(
                        // width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title.toString(),
                              softWrap: true,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              data.description.toString(),
                              maxLines: 2,
                              softWrap: true,
                            ),
                            Text("Price : ${data.price.toString()} Rs."),
                            Text(data.category.toString()),
                            Row(
                              children: [
                                Text(data.rating.toString()),
                                Text(
                                  data.discountPercentage.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  GridView DesktopScreen(ProductListProvider value) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
        primary: true,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: size.width > 1100 ? 16 / 13 : 9 / 13,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12),
        itemCount: value.productList.data!.products!.length,
        itemBuilder: (context, index) {
          var data = value.productList.data!.products![index];
          return InkWell(
            onTap: () {
              int? product_id = data.id;
              Navigator.pushNamed(context, RouteName.singleProductScreen,
                  arguments: product_id);
            },
            child: ColoredBox(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.transparent,
                      child: Image.network(
                        data.thumbnail.toString(),
                        fit: BoxFit.cover,
                        scale: 1.0,
                        height: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title.toString(),
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data.description.toString(),
                            maxLines: 2,
                            softWrap: true,
                          ),
                          Text("Price : ${data.price.toString()} Rs."),
                          Text(data.category.toString()),
                          Row(
                            children: [
                              Text(data.rating.toString()),
                              Text(
                                data.discountPercentage.toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
