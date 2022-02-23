import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const productDetail = "/productDetail";
  // const ProductDetailScreen({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: SafeArea(child: Container()),
    );
  }
}
