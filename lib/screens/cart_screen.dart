import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/cart.dart';

import 'package:wecode_final/widgets/cart_item.dart';

import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const cartScreen = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: Chip(
                      label: Text(
                        "\$${cart.totalAmount}",
                        style: TextStyle(color: kWhite),
                      ),
                      backgroundColor: kLightBlue,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clear();
                      },
                      child: Text("Order Now"))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final getCart = cart.items.values.toList()[index];
                  return CartItems(
                      id: getCart.id,
                      productId: cart.items.keys.toList()[index],
                      title: getCart.title,
                      quantity: getCart.quantity,
                      price: getCart.price);
                }),
          ),
        ],
      ),
    );
  }
}
