import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecode_final/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products; //quantity
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final Uri url = Uri.parse(
      'https://wecodefinal-default-rtdb.firebaseio.com/orders.json',
    );
    http.Response response = await http.get(url);
    final List<OrderItem> loadingOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == Null) {
      return;
    }
    // try {
    extractedData.forEach((orderId, OrderData) {
      loadingOrders.add(
        OrderItem(
          id: orderId,
          amount: OrderData['amount'],
          products: (OrderData['products'] as List<dynamic>)
              .map(
                (e) => CartItem(e['id'], e['title'], e['quantity'], e['price']),
              )
              .toList(),
          dateTime: DateTime.parse(
            OrderData['dateTime'],
          ),
        ),
      );
    });
    _orders = loadingOrders.reversed.toList();
    notifyListeners();
    // } catch (e) {
    //   throw e;
    // }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final Uri url = Uri.parse(
      'https://wecodefinal-default-rtdb.firebaseio.com/orders.json',
    );
    final timestamp = DateTime.now();
    try {
      http.Response response = await http.post(url,
          body: jsonEncode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProduct
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: jsonDecode(response.body)['name'],
              amount: total,
              products: cartProduct,
              dateTime: DateTime.now()));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
