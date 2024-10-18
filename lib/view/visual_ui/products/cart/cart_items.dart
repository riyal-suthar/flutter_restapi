import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/viewModel/cart_list_provider.dart';
import 'package:provider/provider.dart';
import '../../../../data/services/api_response.dart';
import '../../../../routes/routes_name.dart';
import 'cart_item.dart';

class CartItems extends StatefulWidget {
  final userId;
  const CartItems({super.key, this.userId});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  CartListProvider cartListProvider = CartListProvider();

  @override
  void initState() {
    cartListProvider.userCart(widget.userId);
    super.initState();
  }

  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => cartListProvider,
        child: Consumer<CartListProvider>(builder: (context, value, _) {
          switch (value.userCartList.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Text(value.userCartList.message.toString()),
              );
            case Status.complete:
              return Scaffold(
                bottomNavigationBar: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: value.userCartList.data!.carts!.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${value.userCartList.data!.carts![0].total} Rs.",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Disc. Price",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${value.userCartList.data!.carts![0].discountedTotal} Rs.",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Products ",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      value.userCartList.data!.carts![0]
                                          .totalProducts
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Quantity ",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      value.userCartList.data!.carts![0]
                                          .totalQuantity
                                          .toString(),
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
                ),
                appBar: AppBar(
                  title: const Text("Cart"),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        value.removeCartList(widget.userId);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                body: value.userCartList.data!.carts!.isEmpty
                    ? const Center(child: Text("Cart is Empty"))
                    : ListView.builder(
                        itemCount:
                            value.userCartList.data!.carts![0].products!.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (ctx, index) {
                          var item = value
                              .userCartList.data!.carts![0].products![index];
                          print("item id :${item.id}");
                          return CartItem(
                            item: item,
                            onMinusQty: () {
                              if (qty > 1) {
                                qty--;
                                value.updateLocalQty(index, qty);
                              }
                            },
                            onRemoveCart: () {
                              value.removeFromLocalCart(index);
                            },
                            onAddQty: () {
                              qty++;
                              value.updateLocalQty(index, qty);
                            },
                          );
                        }),
              );
            default:
              return const SizedBox();
          }
        }));
  }
}
