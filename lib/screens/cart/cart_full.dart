import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/inner_screens/product_detail.dart';
import 'package:ecommerce_app/models/cart_attr.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({required this.productId});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods=GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttrModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final subTotal = cartAttr.price * cartAttr.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.productId),
      child: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(cartAttr.imageUrl),
                //fit: BoxFit.fill,
              )),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cartAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {
                                globalMethods.showDialogg('Remove item',
                                    'Product will be remove from the cart !',
                                    ()=> cartProvider.removeItem(widget.productId),
                                    context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price'),
                        SizedBox(width: 5),
                        Text(
                          '${cartAttr.price}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sub Total'),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${subTotal.toStringAsFixed(2)}\$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: themeChange.darkTheme
                                    ? Colors.brown.shade900
                                    : Theme.of(context).accentColor),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Ship Free',
                          style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.brown.shade900
                                  : Theme.of(context).accentColor),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: cartAttr.quantity < 2
                                ? null
                                : () {
                                    cartProvider.reduceItemByOne(
                                      widget.productId,
                                    );
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: cartAttr.quantity < 2
                                      ? Colors.grey
                                      : Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              ColorsConsts.gradiendFStart,
                              ColorsConsts.gradiendFEnd,
                            ], stops: [
                              0.0,
                              0.7
                            ])),
                            child: Text(
                              '${cartAttr.quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {
                              cartProvider.addProductToCat(
                                  widget.productId,
                                  cartAttr.price,
                                  cartAttr.title,
                                  cartAttr.imageUrl);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.plus,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
