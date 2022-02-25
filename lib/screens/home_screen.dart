import 'package:flutter/material.dart';
import 'package:wecode_final/app_brain.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/widgets/costume_row.dart';
import 'package:wecode_final/widgets/product_grid.dart';
import 'package:wecode_final/widgets/product_item.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: kWhite,
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.filter_vintage))
        ],
      ),
      body: ListView(
        children: [
          CostumeRow(),
          ProductsGrid(),
        ],
      ),
    );
  }
}
