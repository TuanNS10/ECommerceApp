import 'package:ecommerce_app/inner_screens/upload_product_form.dart';
import 'package:ecommerce_app/screens/bottom_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
