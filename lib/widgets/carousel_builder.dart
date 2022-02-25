import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wecode_final/providers/app_brain.dart';

import 'category_boxes.dart';

class CarouselBuilder extends StatelessWidget {
  const CarouselBuilder(
      {Key? key, required this.itemCount, required this.listOfStrings})
      : super(key: key);
  final int itemCount;
  final List listOfStrings;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (context, index, realIdx) {
        return MaterialBoxes(
          sliderImages: listOfStrings[index],
          text: AppData.textOnImages[index],
        );
      },
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 6),
        viewportFraction: 0.336,
        autoPlay: true,
      ),
    );
  }
}
