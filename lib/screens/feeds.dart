import 'package:badges/badges.dart';
import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:ecommerce_app/screens/cart/carts.dart';
import 'package:ecommerce_app/screens/wishlist/wishlist.dart';
import 'package:ecommerce_app/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/Feeds';

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Future<void> _getProductsOnRefresh() async {
    await Provider.of<ProductsProvider>(context, listen: false).FetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as String;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavsProvider>(context);
    List<Product> productsList = productsProvider.products;
    if (popular == 'popular') {
      productsList = productsProvider.popularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Feeds'),
        actions: [
          Consumer<FavsProvider>(
            builder: (_, fav, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                favProvider.getFavsItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, WishlistScreen.routeName);
                },
                icon: Icon(MyAppIcons.wishlist),
                color: Colors.blue,
              ),
            ),
          ),
          Consumer<CartProvider>(
              builder: (_, cart, ch)=>Badge(
                badgeColor: ColorsConsts.cartColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(cartProvider.getCartItems.length.toString(),
                style: TextStyle(color: Colors.white),),
                child: IconButton(
                  onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
                  icon: Icon(MyAppIcons.cart),
                  color: Colors.blue,
                ),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnRefresh,
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 220 / 420,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            children: List.generate(productsList.length, (index) {
              return ChangeNotifierProvider.value(
                value: productsList[index],
                child: FeedsProducts(),
              );
            })),
      ),
    );
  }
}
