import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/inner_screens/product_detail.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;

  const FeedDialog({required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavsProvider>(context);
    final prodAttr = productsData.findById(productId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.network(prodAttr.imageUrl),
              //Image(
              //image: AssetImage('assets/images/cute.jpg'),
              //),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: dialogContent(
                          context,
                          0,
                          () => {
                                favProvider.addAndRemoveFromFavs(
                                    productId,
                                    prodAttr.price,
                                    prodAttr.title,
                                    prodAttr.imageUrl),
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null
                              })),
                  Flexible(
                    child: dialogContent(
                        context,
                        1,
                        () => {
                              Navigator.pushNamed(
                                      context, ProductDetails.routeName,
                                      arguments: prodAttr.id)
                                  .then((value) => Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null)
                            }),
                  ),
                  Flexible(
                      child: dialogContent(
                          context,
                          2,
                          () => {
                                cartProvider.addProductToCat(
                                    productId,
                                    prodAttr.price,
                                    prodAttr.title,
                                    prodAttr.imageUrl),
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null
                              }))
                ],
              ),
            ),
            //****************** IconButton Close ***************//
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, VoidCallback fct) {
    final cart = Provider.of<CartProvider>(context);
    final fav = Provider.of<FavsProvider>(context);
    List<IconData> _dialogIcons = [
      fav.getFavsItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Feather.eye,
      MyAppIcons.cart,
      MyAppIcons.trash
    ];

    List<String> _text = [
      fav.getFavsItems.containsKey(productId)
          ? 'In Wishlist'
          : 'Add to Wishlist',
      'View product',
      cart.getCartItems.containsKey(productId) ? 'In cart' : 'Add to cart',
    ];

    List<Color> _colors = [
      fav.getFavsItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor
    ];
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        )
                      ]),
                  child: ClipOval(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        _dialogIcons[index],
                        color: _colors[index],
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _text[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: themeChange.darkTheme
                              ? Theme.of(context).disabledColor
                              : ColorsConsts.subTitle),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
