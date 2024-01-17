import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/services/api_response.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/viewModel/product_list_provider.dart';
import 'package:provider/provider.dart';

import '../viewModel/cart_list_provider.dart';

class Single_Product_Screen extends StatefulWidget {
  final product_id;
  const Single_Product_Screen({super.key, @required this.product_id});

  @override
  State<Single_Product_Screen> createState() => _Single_Product_ScreenState();
}

class _Single_Product_ScreenState extends State<Single_Product_Screen> {
  SingleProductProvider singleProductProvider = SingleProductProvider();
  @override
  void initState() {
    // singleProductProvider.fetchSingleProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: MultiProvider(
          providers: [
            Provider(
              create: (BuildContext context) => singleProductProvider,
            ),
          ],
          child: Consumer<SingleProductProvider>(
            builder: (context, value, _) {
              var data = value.singleProductDetails.data;
              switch (value.singleProductDetails.status) {
                case Status.loading:
                  print("object");
                  return Center(child: CircularProgressIndicator());
                case Status.error:
                  return Center(
                    child: Text(value.singleProductDetails.message.toString()),
                  );
                case Status.complete:
                  print("Status completed");
                  return buildSingleChildScrollView(data!, context);

                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  buildSingleChildScrollView(Products data, BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (data!.images!.length > 0)
              ? Container(
                  padding: EdgeInsets.only(top: 24),
                  child: CarouselSlider(
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * .30,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 10.0,
                          onPageChanged: (index, reason) {
                            print("page index is " + index.toString());
                            // _currentIndex = index;
                            context
                                .read<SingleProductProvider>()
                                .setImgIndex(index);
                          }),
                      items: data.images!
                          .map(
                            (item) => GestureDetector(
                              onTap: null,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    item.toString(),
                                    fit: BoxFit.fitHeight,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                )
              : SizedBox(),
          SizedBox(
            height: 24,
          ),
          (data.images!.length > 0)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: data.images!.map((urlOfItem) {
                    int index = data.images!.indexOf(urlOfItem);
                    print(index.toString() + "this is the index indicator");
                    return Container(
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(100),
                        shape: BoxShape.circle,
                        color: context.read<SingleProductProvider>().imgindex ==
                                index
                            ? const Color.fromRGBO(0, 0, 0, 0.8)
                            : const Color.fromRGBO(0, 0, 0, .2),
                      ),
                    );
                  }).toList(),
                )
              : SizedBox(),
          SizedBox(
            height: 12,
          ),
          Text(
            data.title.toString(),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Text('Brand : ' + data.brand.toString()),
          Text("Available Stock : " + data.stock.toString()),
          Text('Description :\n' + data.description.toString()),
          Text('Category : ' + data.category.toString()),
          Flex(
            direction: Axis.horizontal,
            children: [
              Text(
                "ratings : " + data.rating.toString(),
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 10,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                data.discountPercentage.toString() + "%",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            data.price.toString() + 'Rs.',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => CartListProvider(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CartListProvider>(builder: (context, val, child) {
                  return OutlinedButton(
                    onPressed: () {
                      Products? cartProduct = context
                          .read<SingleProductProvider>()
                          .singleProductDetails
                          .data;
                      val.addToLocalCart(cartProduct, 1);
                      Navigator.pushNamed(context, RouteName.cartScreen);
                    },
                    child: const Text("ADD TO CART"),
                  );
                }),
                // OutlinedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, RouteName.cartScreen);
                //     Products cartProduct = data;
                //   },
                //   child: const Text("ADD TO CART"),
                // ),
                const SizedBox(
                  width: 24.0,
                ),
                SizedBox(
                  height: 38,
                  width: 140,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.checkOutScreen);
                    },
                    child: const Text("BUY"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
