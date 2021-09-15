import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/inner_screens/product_detail.dart';
import 'package:ecommerce_app/models/favs_attr.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistFull extends StatefulWidget {
  final String productId;

  const WishlistFull({required this.productId});

  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final favAttr = Provider.of<FavsAttr>(context);

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 2, left: 12, right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favAttr.imageUrl),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          favAttr.title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '\$ ${favAttr.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId)
      ],
    );
  }

  Widget positionedRemove(String productId) {
    final favProvider = Provider.of<FavsProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return Positioned(
        top: 0,
        right: 15,
        child: Container(
          height: 30,
          width: 30,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(0.0),
            color: ColorsConsts.favColor,
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () => {
              globalMethods.showDialogg(
                  'Remove wish',
                  'This product will be removed from your wishlist !',
                  () => favProvider.removeItem(productId),
                  context)
            },
          ),
        ));
  }
}
