import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecode_final/providers/app_brain.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<AppData> _items = [
    // AppData(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // AppData(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // AppData(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // AppData(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  String authToken;

  final String userId;

  Products(this.authToken, this.userId, this._items);
  // bool _showFavourite = false;
  List<AppData> get items {
    // if (_showFavourite) {

    // }
    return [..._items];
  }

  List<AppData> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  AppData findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProducts() {
    notifyListeners();
  }

  // void showFavourite() {
  //   _showFavourite = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavourite = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    // try {
    Uri url = Uri.parse(
      'https://wecodefinal-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString',
    ); //to create a new products.json if its not there as a file to save
    http.Response response = await http.get(url);
    Map<String, dynamic> exractedData =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<AppData> loadedProducts = [];
    if (exractedData == null) {
      return;
    }
    url = Uri.parse(
        'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
    final favoriteResponse = await http.get(url);
    final favoriteData = json.decode(favoriteResponse.body);
    try {
      exractedData.forEach((prodId, prodData) {
        loadedProducts.add(AppData(
            id: prodId, //because its the key that firebase is created as an id
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavourite: prodData['isFavourite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
    // if (response.statusCode == 200) {

    // }
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }

  Future<void> addProduct(AppData product) async {
    final Uri url = Uri.parse(
      'https://wecodefinal-default-rtdb.firebaseio.com/products.json?auth=$authToken',
    ); //to create a new products.json if its not there as a file to save file bu post request
    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite,
          },
        ),
      );

      final newProducts = AppData(
        id: jsonDecode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavourite: product.isFavourite,
      );
      _items.insert(0, newProducts); //Adding it to the top of the products
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }

    // }).catchError((error) {
    //   print(error);
    //   throw error;
    // });
    // return Future.value(); basically returns a future value or no value
    // _items.add(newProducts);
  }

  Future<void> updateProduct(String id, AppData newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      try {
        final Uri url = Uri.parse(
          'https://wecodefinal-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken',
        ); //to create a new pr
        await http.patch(url,
            body: jsonEncode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
              'title': newProduct.title,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print('...');
    }
  }

  void removeProduct(String id) {
    final Uri url = Uri.parse(
      'https://wecodefinal-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken',
    );
    final existingIndex = _items.indexWhere((element) => element.id == id);
    AppData existing = _items[existingIndex];

    http.delete(url).then((_) {
      existing = Null as AppData;
    }).catchError((error) {
      _items.insert(existingIndex, existing);
      notifyListeners();
    });
    _items.removeAt(existingIndex);
    notifyListeners();
  }
}
