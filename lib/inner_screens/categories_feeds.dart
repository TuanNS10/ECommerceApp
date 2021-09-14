import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:ecommerce_app/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    print(categoryName);
    final productsList = productsProvider.findByCategory(categoryName);
    return Scaffold(
      body: productsList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Feather.database, size: 80,),
                Text(
                  'No products related to this category',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 220 / 440,
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
