import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/app_brain.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/screens/cart_screen.dart';
import 'package:wecode_final/widgets/app_drawer.dart';
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
  static const routeName = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFavourite = false;
  bool _isInit = true;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  } //to load until products is loaded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton,
      appBar: AppBar(
        primary: true,
        backgroundColor: kWhite,
        foregroundColor: kMainBlue,
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
                icon: const Icon(Icons.filter_vintage),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text('My Favourites'),
                    value: FilterOptions.Favourite,
                  ),
                  const PopupMenuItem(
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
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
