import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/screens/cart/carts.dart';
import 'package:ecommerce_app/screens/user_info.dart';
import 'package:ecommerce_app/screens/wishlist/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByHeader extends SliverPersistentHeaderDelegate {
  final double flexibleSpace;
  final double backgroundHeight;
  final double stackPaddingTop;
  final double titlePaddingTop;
  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? action;
  final Widget stackChild;

  SearchByHeader(
      {this.flexibleSpace = 250,
      this.backgroundHeight = 200,
      required this.stackPaddingTop,
      this.titlePaddingTop = 25,
      required this.title,
      this.subTitle,
      this.leading,
      this.action,
      required this.stackChild});

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userImageUrl;
  String? _uid;

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      _userImageUrl = userDoc.get('imageUrl');
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var percent = shrinkOffset / (maxExtent - minExtent);
    double calculate = 1 - percent < 0 ? 0 : (1 - percent);
    return SizedBox(
      height: maxExtent,
      child: Stack(
        children: <Widget>[
          Container(
            height: minExtent + ((backgroundHeight - minExtent) * calculate),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      ColorsConsts.starterColor,
                      ColorsConsts.endColor,
                    ],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<FavsProvider>(
                  builder: (_, fav, ch) => Badge(
                    badgeColor: ColorsConsts.favColor,
                    position: BadgePosition.topEnd(top: 5, end: 7),
                    badgeContent: Text(
                      fav.getFavsItems.length.toString(),
                      style: TextStyle(color: ColorsConsts.white),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: ColorsConsts.favColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, WishlistScreen.routeName);
                      },
                    ),
                  ),
                ),
                Consumer<CartProvider>(
                    builder: (_, cart, ch) => Badge(
                          badgeColor: ColorsConsts.cartColor,
                          position: BadgePosition.topEnd(top: 5, end: 7),
                          badgeContent: Text(
                            cart.getCartItems.length.toString(),
                            style: TextStyle(color: ColorsConsts.white),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: ColorsConsts.cartColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CartScreen.routeName);
                            },
                          ),
                        ))
              ],
            ),
          ),
          Positioned(
            top: 32,
            left: 10,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade300,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                splashColor: Colors.grey,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreen(),
                  ),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: _userImageUrl == null
                              ? AssetImage('assets/images/girl.jpg')
                                  as ImageProvider
                              : NetworkImage(_userImageUrl!),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: titlePaddingTop * calculate + 27,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  leading ?? SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Transform.scale(
                        alignment: Alignment.centerLeft,
                        scale: 1 + (calculate * .5),
                        child: Padding(
                          padding: EdgeInsets.only(top: 14 * (1 - calculate)),
                          child: title,
                        ),
                      ),
                      if (calculate > .5) ...[
                        SizedBox(
                          height: 10,
                        ),
                        Opacity(
                          opacity: calculate,
                          child: subTitle ?? SizedBox(),
                        )
                      ]
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(top: 14 * calculate),
                    child: action ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: minExtent + ((stackPaddingTop - minExtent) * calculate),
            child: Opacity(
              opacity: calculate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: stackChild,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => flexibleSpace;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
