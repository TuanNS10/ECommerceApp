import 'package:ecommerce_app/bottom_bar.dart';
import 'package:ecommerce_app/consts/theme_data.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themData, child) {
        return MaterialApp(
            title: 'ECommerce App',
            theme: Styles.themData(themeChangeProvider.darkTheme, context),
            home: BottomBarScreen());
      }),
    );
  }
}
