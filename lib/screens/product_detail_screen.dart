import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const productDetail = "/productDetail";
  // const ProductDetailScreen({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SafeArea(child: Container()),
    );
  }
}
