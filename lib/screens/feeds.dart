import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:ecommerce_app/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';

  @override
  Widget build(BuildContext context) {
    final productsProvider=Provider.of<ProductsProvider>(context);
    List<Product> productsList=productsProvider.products;
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 220 / 360,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          children: List.generate(productsList.length, (index) {
            return ChangeNotifierProvider.value(
              value: productsList[index],
              child: FeedsProducts(),
            );
          })),
    );
  }
}
