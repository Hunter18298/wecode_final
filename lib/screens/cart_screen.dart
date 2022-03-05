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
                        "\$${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: kWhite),
                      ),
                      backgroundColor: kLightBlue,
                    ),
                  ),
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null //for disabling button when there is no items
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              widget.cart.clear();
              setState(() {
                _isLoading = false;
              });
            },
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text("Order Now"),
    );
  }
}
