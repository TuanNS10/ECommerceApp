import 'package:flutter/material.dart';

class CartAttrModel with ChangeNotifier {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartAttrModel(
      {required this.id,
      required this.productId,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl});
}
