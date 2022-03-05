import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/app_brain.dart';
import 'package:wecode_final/providers/auth.dart';
import 'package:wecode_final/providers/cart.dart';
import 'package:wecode_final/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem(
  //     {Key? key, required this.id, required this.imageUrl, required this.title})
  //     : super(key: key);
  // final String id;
  // final String imageUrl;
  // final String title;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<AppData>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return Consumer<AppData>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailScreen.productDetail,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined),
                onPressed: () {
                  product.toggleFavoriteStatus(
                    authData.token,
                    authData.userId,
                  );
                }),
            trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  cart.addProduct(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Items is added"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: "undo",
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
