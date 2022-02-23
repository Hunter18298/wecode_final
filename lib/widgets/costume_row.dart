import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wecode_final/app_brain.dart';
import 'package:wecode_final/widgets/carousel_builder.dart';
import 'package:wecode_final/widgets/category_boxes.dart';

//home screen row and carousel biulder

class CostumeRow extends StatelessWidget {
  const CostumeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: CarouselBuilder(
          itemCount: AppData.images.length, listOfStrings: AppData.images),
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       MaterialBoxes(),
      //       MaterialBoxes(),
      //       MaterialBoxes(),
      //       MaterialBoxes(),
      //     ],
      //   ),
      // ),
    );
  }

  // CarouselSlider CarouselBuilder() {
  //   return CarouselSlider.builder(
  //     itemCount: AppData.images.length,
  //     itemBuilder: (context, index, realIdx) {
  //       return MaterialBoxes(
  //         sliderImages: AppData.images[index],
  //       );
  //     },
  //     options: CarouselOptions(
  //       autoPlayInterval: const Duration(seconds: 6),
  //       viewportFraction: 0.336,
  //       autoPlay: true,
  //     ),
  //   );
  // }
}
