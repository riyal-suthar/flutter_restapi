import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Products? item;
  final Function()? onPressed;
  final bool selected;
  const ProductItem({
    super.key,
    required this.item,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).primaryColor
                  : Colors.white.withOpacity(0.8),
              // : Colors.indigoAccent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: Hero(
              tag: "${item!.id}",
              child: Image.network(
                item!.thumbnail.toString(),
                fit: BoxFit.contain,
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              item!.title.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Text(
            "Rs. ${item!.price.toString()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
