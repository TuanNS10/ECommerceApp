import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/my_icons.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:ecommerce_app/screens/carts.dart';
import 'package:ecommerce_app/screens/wishlist.dart';
import 'package:ecommerce_app/widget/feeds_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60.0),
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU'),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 260,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(10.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                'title',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'US \$ 15',
                              style: TextStyle(
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21.0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 21.0,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _detail(themeState.darkTheme, 'Brand: ', 'BrandName'),
                      _detail(themeState.darkTheme, 'Quantity:  ', '12 Left'),
                      _detail(themeState.darkTheme, 'Category:  ', 'Cat Name'),
                      _detail(themeState.darkTheme, 'Popularity:  ', 'Popular'),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'By the first review!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 80.0,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return FeedsProducts();
                    },
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.red.shade400,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'DETAIL',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                  icon: Icon(MyAppIcons.wishlist),
                  color: Colors.blue,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    icon: Icon(
                      MyAppIcons.cart,
                      color: ColorsConsts.cartColor,
                    ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(side: BorderSide.none),
                        color: Colors.redAccent.shade400,
                        onPressed: () {},
                        child: Text(
                          'Add to Cart'.toUpperCase(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(side: BorderSide.none),
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'Buy Now'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).textSelectionColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.payment,
                              color: Colors.green.shade700,
                              size: 19,
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                        splashColor: ColorsConsts.favColor,
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            MyAppIcons.wishlist,
                            color: ColorsConsts.white,
                          ),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detail(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
                color: themeState
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
