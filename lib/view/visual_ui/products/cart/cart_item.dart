import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_restapi/data/models/userCart_model.dart';

class CartItem extends StatelessWidget {
  final CartProducts item;
  final Function() onRemoveCart;
  final Function() onMinusQty;
  final Function() onAddQty;
  const CartItem({
    super.key,
    required this.item,
    required this.onRemoveCart,
    required this.onMinusQty,
    required this.onAddQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(
          12,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              child: Image.network(
                item.thumbnail.toString(),
                fit: BoxFit.contain,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                item.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: onMinusQty,
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: onAddQty,
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
                          item.price.toString() + " Rs.",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: onRemoveCart,
                        child: CircleAvatar(
                            maxRadius: 13,
                            child: Icon(
                              Icons.delete,
                              size: 17,
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
