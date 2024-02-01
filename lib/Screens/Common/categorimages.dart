import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorImages {
  Widget categoryimages(category) {
    String imagePath;
    switch (category) {
      case "Medical":
        imagePath = "Assets/medical.svg";
        break;
      case "Shopping":
        imagePath = "Assets/shopping.svg";
        break;
      case "Food":
        imagePath = "Assets/food.svg";
        break;
      default:
        imagePath = "Assets/others.svg";
        break;
    }
    return CircleAvatar(
      backgroundColor: Colors.grey[300],
      // foregroundColor: Colors.white,
      child: Center(
          child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.fill,
      )),
    );
  }
}
