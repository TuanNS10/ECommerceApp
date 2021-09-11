import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:ecommerce_app/screens/carts.dart';
import 'package:ecommerce_app/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _joinedAt;
  String? _userImageUrl;
  int? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    print('displayName ${user.email}');

    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        :await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if(userDoc == null){
      return;
    }else{
      setState(() {
        _name = userDoc.get('name');
        _email = userDoc.get('email');
        _phoneNumber = userDoc.get('phoneNumber');
        _joinedAt = userDoc.get('joinedAt');
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;

                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.deepPurple],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  child: FlexibleSpaceBar(
                    //collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: top <= 100.0 ? 1.0 : 0,
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Container(
                            height: kToolbarHeight / 1.8,
                            width: kToolbarHeight / 1.8,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white, blurRadius: 1.0)
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: _userImageUrl == null
                                        ? AssetImage('assets/images/cute.jpg') as ImageProvider
                                        : NetworkImage(_userImageUrl!)
                                )),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                             _name == null ? 'Guest': _name!,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    background: Image(
                      image: _userImageUrl == null
                          ? AssetImage('assets/images/cute.jpg')
                              as ImageProvider
                          : NetworkImage(_userImageUrl!),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle(title: 'User Bag'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(WishlistScreen.routeName);
                      },
                      splashColor: Colors.red,
                      child: ListTile(
                        title: Text('Wishlist'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(Feather.heart),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      splashColor: Colors.red,
                      child: ListTile(
                        title: Text('Cart'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(Feather.shopping_cart),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('My Orders'),
                    trailing: Icon(Icons.chevron_right_rounded),
                    leading: Icon(Feather.shopping_bag),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle(title: 'User Information'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  userListTile('Email', _email ?? '', 0, context),
                  userListTile(
                      'Phone number',  _phoneNumber.toString() ?? '', 1, context),
                  userListTile('Shipping address', '', 2, context),
                  userListTile('joined date', _joinedAt ?? '', 3, context),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle(title: 'User setting'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    leading: Icon(Ionicons.md_moon),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: Text('Dark theme'),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Image.network(
                                              'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Sign out'),
                                          )
                                        ],
                                      ),
                                      content: Text('Do you wanna Sign out?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              await _auth.signOut().then(
                                                  (value) =>
                                                      Navigator.pop(context));
                                            },
                                            child: Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ))
                                      ],
                                    );
                                  });
                        },
                        title: Text('Logout'),
                        leading: Icon(Icons.exit_to_app_rounded),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        _buildFab()
      ],
    ));
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTitleIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subtitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(_userTitleIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
