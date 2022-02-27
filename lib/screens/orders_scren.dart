import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/orders.dart';
import 'package:wecode_final/widgets/order_item.dart';

class OrdersScren extends StatelessWidget {
  const OrdersScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) {
            return OrderItems(
              order: orderData.orders[index],
            );
          },
        ),
      ),
    );
  }
}
