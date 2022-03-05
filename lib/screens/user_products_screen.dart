import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/screens/edit_product_screen.dart';
import 'package:wecode_final/widgets/app_drawer.dart';
import 'package:wecode_final/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = "/add_product";

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshProducts() async {
      return await Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts();
    }

    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     if (Scaffold.hasDrawer(context)) {
        //       Scaffold.of(context).openDrawer();
        //       AppDrawer();
        //     }
        //   },
        //   icon: Icon(Icons.menu),
        // ),
        automaticallyImplyLeading: false,
        title: const Text("products"),
        centerTitle: true,
        actions: [
          IconButton(
            color: kWhite,
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, index) => Column(
              children: [
                UserProductItem(
                    id: productsData.items[index].id,
                    imageUrl: productsData.items[index].imageUrl,
                    title: productsData.items[index].title),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
