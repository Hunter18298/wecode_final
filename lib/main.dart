import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/cart.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/screens/cart_screen.dart';
import 'package:wecode_final/screens/edit_product_screen.dart';
import 'package:wecode_final/screens/home_screen.dart';
import 'package:wecode_final/providers/orders.dart';
import 'package:wecode_final/screens/orders_scren.dart';
import 'package:wecode_final/screens/product_detail_screen.dart';
import 'package:wecode_final/screens/user_products_screen.dart';

//main  of these app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeShop',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: kLightBlue,
              actionsIconTheme: IconThemeData(color: kMainBlue, size: 30)),
          colorScheme: ColorScheme.light().copyWith(
            primary: kMainBlue,
            secondary: kMainYellow,
          ),
        ),
        home: HomePage(),
        routes: {
          ProductDetailScreen.productDetail: (context) => ProductDetailScreen(),
          CartScreen.cartScreen: (context) => const CartScreen(),
          OrdersScren.routeName: (context) => OrdersScren(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen()
        },
      ),
    );
  }
}
