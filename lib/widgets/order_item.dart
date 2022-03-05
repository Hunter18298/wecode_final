import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/cart.dart';
import 'package:wecode_final/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatefulWidget {
  final OrderItem? order;

  const OrderItems({Key? key, this.order}) : super(key: key);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
                title: Text("\$${widget.order!.amount.toStringAsFixed(2)}"),
                subtitle: Text(DateFormat("dd/MM/yyyy hh:mm")
                    .format(widget.order!.dateTime)),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                )),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
              height: min(widget.order!.products.length * 20 + 10, 100),
              child: ListView(
                children: widget.order!.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            Text(
                              '${prod.quantity}/ \$${prod.price}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
