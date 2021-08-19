import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:ecommerce_app/widget/wishlist_empty.dart';
import 'package:ecommerce_app/widget/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favProvider = Provider.of<FavsProvider>(context);

    return favProvider.getFavsItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist (${favProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                      globalMethods.showDialogg(
                          'Clear wishlist',
                          'Your wishlist will be cleared !',
                          () => favProvider.clearFavs(),
                          context);
                    },
                    icon: Icon(MyAppIcons.trash)),
              ],
            ),
            body: ListView.builder(
              itemCount: favProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: favProvider.getFavsItems.values.toList()[index],
                  child: WishlistFull(
                    productId: favProvider.getFavsItems.keys.toList()[index],
                  ),
                );
              },
            ),
          );
  }
}
