import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/screens/upload_product_form.dart';
import 'package:ecommerce_app/screens/cart/carts.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:ecommerce_app/screens/wishlist/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackLayerMenu extends StatefulWidget {
  BackLayerMenu({Key? key}) : super(key: key);

  @override
  _BackLayerMenuState createState() => _BackLayerMenuState();
}

class _BackLayerMenuState extends State<BackLayerMenu> {
  FirebaseAuth _auth= FirebaseAuth.instance;

  String? _userImageUrl;
  String? _uid;
  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ColorsConsts.starterColor, ColorsConsts.endColor],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp)),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3)),
              width: 150,
              height: 250,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 100.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3)),
              width: 150,
              height: 300,
            ),
          ),
        ),
        Positioned(
            top: -50.0,
            left: 60.0,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3)),
                width: 150,
                height: 200,
              ),
            )),
        Positioned(
            bottom: 10.0,
            right: 0.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3)),
                width: 150,
                height: 200,
              ),
            )),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: _userImageUrl == null
                                  ? AssetImage('assets/images/cute.jpg') as ImageProvider
                                  :NetworkImage(_userImageUrl!),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                content(context, () {
                  navigateTo(context, FeedsScreen.routeName);
                }, 'Feeds', 0),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, CartScreen.routeName);
                }, 'Cart', 1),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, WishlistScreen.routeName);
                }, 'Wishlist', 2),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, UploadProductForm.routeName);
                }, 'Upload a new product', 3),
              ],
            ),
          ),
        )
      ],
    );
  }

  List _contentIcons = [
    MyAppIcons.feeds,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    MyAppIcons.upload
  ];

  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  Widget content(
      BuildContext ctx, final VoidCallback fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}
