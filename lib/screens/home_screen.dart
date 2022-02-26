import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/app_brain.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/screens/cart_screen.dart';
import 'package:wecode_final/widgets/badge.dart';
import 'package:wecode_final/widgets/costume_row.dart';
import 'package:wecode_final/widgets/product_grid.dart';
import 'package:wecode_final/widgets/product_item.dart';

import '../providers/cart.dart';

enum FilterOptions {
  Favourite,
  All,
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton,
      appBar: AppBar(
        primary: true,
        backgroundColor: kWhite,
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: PopupMenuButton(
                onSelected: (FilterOptions selectedItem) {
                  setState(() {
                    if (selectedItem == FilterOptions.Favourite) {
                      _showFavourite = true;
                    } else {
                      _showFavourite = false;
                    }
                  });
                },
                icon: Icon(Icons.filter_vintage),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('My Favourites'),
                    value: FilterOptions.Favourite,
                  ),
                  PopupMenuItem(
                    child: Text('All'),
                    value: FilterOptions.All,
                  ),
                ],
              )),
          Consumer<Cart>(
            builder: (context, cartData, ch) =>
                Badge(child: ch!, value: cartData.itemCount.toString()),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.cartScreen);
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          CostumeRow(),
          ProductsGrid(
            showFavs: _showFavourite,
          ),
        ],
      ),
    );
  }
}
