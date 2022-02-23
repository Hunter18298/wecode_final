import 'package:flutter/material.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.id, required this.imageUrl, required this.title})
      : super(key: key);
  final String id;
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.productDetail,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              icon: Icon(Icons.favorite_border_outlined), onPressed: () {}),
          trailing:
              IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: () {}),
        ),
      ),
    );
  }
}
