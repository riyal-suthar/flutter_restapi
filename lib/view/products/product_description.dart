import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/repository/repository.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/view/products/product_items.dart';
import 'package:flutter_restapi/viewModel/cart_list_provider.dart';
import 'package:provider/provider.dart';

import '../../data/services/api_response.dart';
import '../../utils/toastMessage.dart';
import '../../viewModel/product_list_provider.dart';
import '../responsive_layout.dart';

class ProductDescription extends StatefulWidget {
  final product_id;
  ProductDescription({
    super.key,
    this.product_id,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  SingleProductProvider singleProductProvider = SingleProductProvider();

  CartListProvider cartListProvider = CartListProvider();

  @override
  void initState() {
    // var pid = singleProductProvider.pid;
    singleProductProvider.fetchSingleProductDetails(3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<Products> idIs =
    //     ValueNotifier(singleProductProvider.singleProductDetails.data! ?? pp);
    // var id = context.watch<SingleProductProvider>().pid;
    // final cartListProvider = Provider.of<CartListProvider>(context);
    print("called");
    // Products? snap =
    //     context.watch<SingleProductProvider>().singleProductDetails.data;
    // if (snap == null) CircularProgressIndicator();
    // return Material(
    //   child: Center(
    //     child: Text(snap!.title.toString() ?? "gfdgfd"),
    //   ),
    // );
    return buildValueListenableBuilder();
  }

  ValueListenableBuilder buildValueListenableBuilder() {
    return ValueListenableBuilder<int>(
        valueListenable: idIs,
        builder: (context, val, _) {
          if (val == null) {
            return Center(child: Text("va l is null"));
          }

          singleProductProvider.fetchSingleProductDetails(val);

          return buildChangeNotifierProvider();
        });
  }

  buildChangeNotifierProvider() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => singleProductProvider,
      child: Consumer<SingleProductProvider>(
        builder: (BuildContext context, SingleProductProvider singleProd,
            Widget? child) {
          // print(singleProductProvider.toString());

          var data = singleProd.singleProductDetails.data;
          if (data == null || singleProd.singleProductDetails == null)
            CircularProgressIndicator();

          switch (singleProd.singleProductDetails.status) {
            case Status.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Text(singleProd.singleProductDetails.message.toString()),
              );
            case Status.complete:
              return buildContainer(context, singleProd, data);
            default:
              return SizedBox();
          }
        },
      ),
    );
  }

  Container buildContainer(
      BuildContext context, SingleProductProvider singleProd, Products? data) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (ResponsiveLayout.isMobile(context)) BackButton(),
                if (ResponsiveLayout.isDesktop(context))
                  IconButton(
                    icon: Icon(
                      Icons.print_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {},
                  ),
                Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 100,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).canvasColor)),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                    ),
                    onPressed: () {
                      Map data = {
                        "userId": user!.id.toString(),
                        "products": [
                          {
                            "id": singleProd.singleProductDetails.data!.id,
                            "quantity": 1,
                          }
                        ]
                      };
                      cartListProvider.addToCart(data);
                    },
                  ),
                ),
                SizedBox(width: 20),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 100,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.checkOutScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 24,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(ImageAssets.instance.appLogin),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Sellar  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      children: [
                                        TextSpan(
                                            text: "Platinum Member",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.5))),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    data!.title.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Rs.${data!.price.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.blue)),
                          ],
                        ),
                        SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) => SizedBox(
                            width: constraints.maxWidth > 840
                                ? 800
                                : constraints.maxWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: List.generate(
                                        data.images!.length,
                                        (index) => AnimatedScale(
                                          scale: singleProd.imgindex == index
                                              ? 1.3
                                              : 1.0,
                                          curve: Curves.easeOut,
                                          duration: Duration(milliseconds: 500),
                                          child: Image.network(
                                            data.images![index].toString(),
                                            height: 70,
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    if (constraints.maxWidth > 300)
                                      Expanded(
                                        child: Container(
                                          width: constraints.maxWidth > 840
                                              ? 600
                                              : constraints.maxWidth - 200,
                                          child: CarouselSlider(
                                              options: CarouselOptions(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .30,
                                                  viewportFraction: 1.0,
                                                  autoPlay: true,
                                                  enlargeCenterPage: true,
                                                  aspectRatio: 10.0,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    context
                                                        .read<
                                                            SingleProductProvider>()
                                                        .setImgIndex(index);
                                                  }),
                                              items: List.generate(
                                                  data.images!.length,
                                                  (index) => GestureDetector(
                                                        onTap: null,
                                                        child: Container(
                                                          child: ClipRRect(
                                                            child:
                                                                Image.network(
                                                              data.images![
                                                                      index]
                                                                  .toString(),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ))),
                                        ),
                                      ),
                                  ],
                                ),
                                Divider(thickness: 1),
                                SizedBox(height: 10),
                                Text(
                                  "Available Stock : " + data.stock.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  data.description.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "Category: " + data.category.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "Brand: " + data.description.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Spacer(),
                                    Text("Ratings: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    ...List.generate(5, (i) {
                                      return Icon(
                                        i < data.rating!.floor()
                                            ? Icons.star_rounded
                                            : Icons.star_border_rounded,
                                        color: Theme.of(context).primaryColor,
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class SingleProd extends StatefulWidget {
//   const SingleProd({super.key});
//
//   @override
//   State<SingleProd> createState() => _SingleProdState();
// }
//
// class _SingleProdState extends State<SingleProd> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // var i = context.read<SingleProductProvider>().pid;
//     SingleProductProvider().fetchSingleProductDetails(3);
//     // context.watch<SingleProductProvider>().fetchSingleProductDetails(i);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => SingleProductProvider(),
//       child: Selector<SingleProductProvider, Products>(
//         selector: (_, provider) => provider.singleProductDetails.data!,
//         builder: (_, val, __) {
//           return Container(
//             child: Text(val!.title.toString()),
//           );
//         },
//       ),
//     );
//   }
// }
