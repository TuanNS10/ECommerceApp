import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:ecommerce_app/widget/cart_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widget/cart_full.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear cart',
                        'Your cart will be cleared !',
                        () => cartProvider.clearCart(),
                        context);
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
            body: Container(
              // padding: const EdgeInsets.only(bottom: 30),
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double subTotal) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.grey, width: 6.0),
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(ctx).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total',
              style: TextStyle(
                  color: Theme.of(ctx).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              ' \$${subTotal.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
