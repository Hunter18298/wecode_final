import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/app_brain.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingProduct = Provider.of<Products>(context).items;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0),
        itemBuilder: (context, index) {
          return ProductItem(
            id: loadingProduct[index].id,
            imageUrl: loadingProduct[index].imageUrl,
            title: loadingProduct[index].title,
          );
        },
        itemCount: loadingProduct.length,
      ),
    );
  }
}
