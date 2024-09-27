import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/viewModel/cart_list_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => CartListProvider(),
        child: Consumer<CartListProvider>(builder: (context, value, _) {
          debugPrint(cartList.length);
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          value.totalLocalPrice().toString() + "Rs.",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.checkOutScreen);
                        },
                        child: const Text("Checkout"))
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: const Text("Cart"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ListView.builder(
                itemCount: cartList.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (ctx, index) {
                  var item = cartList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 140,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            child: Image.network(
                              item[0].thumbnail.toString(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              item[0].title.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              CupertinoButton(
                                                onPressed: () {
                                                  if (qty > 1) {
                                                    qty--;
                                                    value.updateLocalQty(
                                                        index, qty);
                                                  }
                                                },
                                                padding: EdgeInsets.zero,
                                                child: const CircleAvatar(
                                                  maxRadius: 13,
                                                  child: Icon(Icons.remove),
                                                ),
                                              ),
                                              Text(
                                                item[1].toString(),
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              CupertinoButton(
                                                onPressed: () {
                                                  qty++;
                                                  value.updateLocalQty(
                                                      index, qty);
                                                },
                                                padding: EdgeInsets.zero,
                                                child: const CircleAvatar(
                                                  maxRadius: 13,
                                                  child: Icon(Icons.add),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item[0].price.toString() + " Rs.",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        value.removeFromLocalCart(index);
                                      },
                                      child: const CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(
                                          Icons.delete,
                                          size: 17,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        }));
  }
}
