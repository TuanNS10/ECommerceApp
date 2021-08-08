import 'package:ecommerce_app/provider/dark_theme_provider.dart';
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
  //Just and late modifier here, late modifier mean that this variable must
  //be initilized  later on, and we are initializing it in init state
  // You also forget to initialize it in the init state
  // late modifier can be used while declaring a non-nullable
  // variable that’s initialized after its declaration.
  //For more read https://dev.to/pktintali/late-variables-in-dart-dart-learning-series-1-2opf

  late ScrollController _scrollController;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
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
                                    image: NetworkImage(
                                        'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-1/s320x320/120499204_1269155846758366_7760179291059864084_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=7206a8&_nc_ohc=KO2gTJ8LBxUAX_UsMdA&_nc_ht=scontent-hkg4-1.xx&oh=c5a4cb3f939e735e309cf7ced3746f19&oe=61330F5E'))),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Guest',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    background: Image(
                      image: NetworkImage(
                          'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-1/s320x320/120499204_1269155846758366_7760179291059864084_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=7206a8&_nc_ohc=KO2gTJ8LBxUAX_UsMdA&_nc_ht=scontent-hkg4-1.xx&oh=c5a4cb3f939e735e309cf7ced3746f19&oe=61330F5E'),
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
                      onTap: () {},
                      splashColor: Colors.red,
                      child: ListTile(
                        title: Text('Wishlist'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(Feather.heart),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text('Cart'),
                    trailing: Icon(Icons.chevron_right_rounded),
                    leading: Icon(Feather.shopping_cart),
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
                  userListTile('Email', 'Email here', 0, context),
                  userListTile('Phone number', '_phoneNumber', 1, context),
                  userListTile('Shipping address', '', 2, context),
                  userListTile('joined date', '20.2.2021', 3, context),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
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
                                        onPressed: () async {},
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.red),
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
