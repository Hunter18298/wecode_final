import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/orders.dart';
import 'package:wecode_final/widgets/app_drawer.dart';
import 'package:wecode_final/widgets/order_item.dart';

class OrdersScren extends StatefulWidget {
  const OrdersScren({Key? key}) : super(key: key);
  static const routeName = "/order";

  @override
  State<OrdersScren> createState() => _OrdersScrenState();
}

class _OrdersScrenState extends State<OrdersScren> {
  Future? _orderFuture;
  Future _obtainFuture() async {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
          }

          return Consumer<Orders>(
            builder: (context, orderData, child) => ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) {
                return OrderItems(
                  order: orderData.orders[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
