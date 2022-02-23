import 'package:flutter/material.dart';
import 'package:wecode_final/constants.dart';

//this class is for Category section or for a container with image and text over it

class MaterialBoxes extends StatelessWidget {
  MaterialBoxes({Key? key, required this.sliderImages, this.text})
      : super(key: key);
  final String sliderImages;
  final String? text;
  @override
  Widget build(BuildContext context) {
    TextStyle kCategoriesHomeText = TextStyle(
        fontSize: 22 * MediaQuery.of(context).textScaleFactor,
        color: Colors.white,
        fontWeight: FontWeight.bold);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(sliderImages),
            fit: BoxFit.cover,
          ),
        ),
        child: text != null
            ? Text(
                text ?? "",
                style: kCategoriesHomeText,
              )
            : null);
  }
}
