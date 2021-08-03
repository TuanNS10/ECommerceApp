import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: userTitle('User information')),
          Divider(thickness: 1, color: Colors.grey),
          userListTitle('Email', 'admin@gmail.com', 0, context),
          userListTitle('Phone number', '(+84) 342250192', 1, context),
          userListTitle('Shipping Address', 'Ho Chi Minh City', 2, context),
          userListTitle('Joined date', 'Date', 3, context),
          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: userTitle('User setting')),
          Divider(thickness: 1, color: Colors.grey),
          ListTileSwitch(
            value: _value,
            leading: Icon(Ionicons.md_moon),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            visualDensity: VisualDensity.comfortable,
            switchType: SwitchType.cupertino,
            switchActiveColor: Colors.indigo,
            title: Text('Dark theme'),
          ),
          userListTitle('Log out', '', 4, context),
        ],
      )),
    );
  }

  List<IconData> _userTitleIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTitle(
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

  Widget userTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
