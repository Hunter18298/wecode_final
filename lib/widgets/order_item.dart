import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/cart.dart';
import 'package:wecode_final/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatelessWidget {
  final OrderItem? order;

  const OrderItems({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
                title: Text("\$${order!.amount}"),
                subtitle: Text(
                    DateFormat("dd/MM/yyyy hh:mm").format(order!.dateTime)),
                trailing: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: () {},
                )),
          ),
        ],
      ),
    );
  }
}
