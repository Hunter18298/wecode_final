import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/screens/edit_product_screen.dart';
import 'package:wecode_final/widgets/app_drawer.dart';
import 'package:wecode_final/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = "/add_product";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("products"),
        actions: [
          IconButton(
            color: kWhite,
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                  imageUrl: productsData.items[index].imageUrl,
                  title: productsData.items[index].title),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
