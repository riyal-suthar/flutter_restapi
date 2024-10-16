import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/services/api_response.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/view/sec_visual_ui/drawer.dart';
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
    productListProvider.fetchCategoryList();
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Text(value.productList.message.toString()),
              );
            case Status.complete:
              return Scaffold(
                // drawer: (isMobile(context)) ? const Drawer() : Container(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: search,
                          decoration: const InputDecoration(
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
                      const SizedBox(
                        height: 5,
                      ),
                      if (value.categoryList.data != null)
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.categoryList.data!.length,
                              itemBuilder: (context, index) {
                                var x =
                                    value.categoryList.data![index].toString();

                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ChoiceChip.elevated(
                                      label: Text(
                                        x,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
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
                      const SizedBox(
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
        builder: (BuildContext context, BoxConstraints constraint) {
      if (constraint.maxWidth > 650) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: constraint.maxWidth > 600 ? 7 : 9,
                child: desktopScreen(value)),
            Expanded(
                flex: constraint.maxWidth > 1100 ? 3 : 0,
                child: const DrawerView())
          ],
        );
      } else {
        return mobileScreen(value);
      }
    });
  }

  // static bool isMobile(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 600;
  //
  // static bool isDesktop(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 600;

  ListView mobileScreen(ProductListProvider value) {
    return ListView.builder(
        itemCount: value.productList.data!.products!.length,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) {
          var data = value.productList.data!.products![index];
          return InkWell(
            onTap: () {
              int? productId = data.id;
              Navigator.pushNamed(context, RouteName.singleProductScreen,
                  arguments: productId);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              color: Colors.grey.shade300,
              child: Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
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
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title.toString(),
                            softWrap: true,
                            // style: const TextStyle(fontWeight: FontWeight.w600),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            data.description.toString(),
                            maxLines: 2,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Price : ${data.price.toString()} Rs.",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            data.category.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                data.rating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                data.discountPercentage.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  GridView desktopScreen(ProductListProvider value) {
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
              int? productId = data.id;
              Navigator.pushNamed(context, RouteName.singleProductScreen,
                  arguments: productId);
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
                  const SizedBox(
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
                            style: const TextStyle(fontWeight: FontWeight.w600),
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
                                style: const TextStyle(color: Colors.red),
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
