import 'package:ecommerce_app/inner_screens/product_detail.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetails.routeName,
                  arguments: productsAttributes.id);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                productsAttributes.imageUrl,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                        right: 10,
                        top: 8,
                        child: Icon(Entypo.star,
                            color: favProvider.getFavsItems
                                    .containsKey(productsAttributes.id)
                                ? Colors.red
                                : Colors.grey.shade800)),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${productsAttributes.price}',
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsAttributes.title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              productsAttributes.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    cartProvider.addProductToCat(
                                        productsAttributes.id,
                                        productsAttributes.price,
                                        productsAttributes.title,
                                        productsAttributes.imageUrl);
                                  },
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Icon(
                                    cartProvider.getCartItems
                                            .containsKey(productsAttributes.id)
                                        ? MaterialCommunityIcons.check_all
                                        : MaterialCommunityIcons.cart_plus,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
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
