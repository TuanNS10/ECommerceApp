import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  List categories = [
    {
      'categoryName': 'Phones',
      'categoryImagesPath': 'assets/images/CatPhone.jpg',
    },
    {
      'categoryName': 'Beauty&Healthy',
      'categoryImagesPath': 'assets/images/CatBeauty.jpg'
    },
    {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'assets/images/CatLaptops.jpg'
    },
    {
      'categoryName': 'Shoes',
      'categoryImagesPath': 'assets/images/CatShoes.jpg'
    },
    {
      'categoryName': 'Watches',
      'categoryImagesPath': 'assets/images/CatWatchs.jpg'
    },
    {
      'categoryName': 'Clothes',
      'categoryImagesPath': 'assets/images/CatClothes.png'
    },
    {
      'categoryName': 'Furniture',
      'categoryImagesPath': 'assets/images/CatFurnitures.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(categories[index]['categoryImagesPath']),
              fit: BoxFit.cover,
            )),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 150,
        height: 150,
      ),
      Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[index]['categoryName'],
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).textSelectionColor),
            ),
          ))
    ]);
  }
}
