import 'package:badges/badges.dart';
import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/screens/cart/carts.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/user_info.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List? _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      HomeScreen(),
      FeedsScreen(),
      SearchScreen(),
      CartScreen(),
      UserScreen(),
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 3,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(width: 0.5))),
          child: BottomNavigationBar(
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home), tooltip: 'Home', label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.feeds),
                tooltip: 'Feeds',
                label: 'Feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Consumer<CartProvider>(
                    builder: (_, cart, ch) => Badge(
                      badgeColor: ColorsConsts.cartColor,
                      position: BadgePosition.topEnd(top: 5, end: 7),
                      badgeContent: Text(
                        cart.getCartItems.length.toString(),
                        style: TextStyle(color: ColorsConsts.white),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Feather.shopping_cart,
                          color: ColorsConsts.cartColor,
                        ),
                        onPressed: () {}
                      ),
                    )),
                tooltip: 'Cart',
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(MyAppIcons.user),
                tooltip: 'User',
                label: 'User',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        tooltip: 'Search',
        elevation: 5,
        child: (Icon(Icons.search)),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }
}
