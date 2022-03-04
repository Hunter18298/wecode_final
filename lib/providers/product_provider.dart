import 'package:flutter/material.dart';
import 'package:wecode_final/providers/app_brain.dart';

class Products with ChangeNotifier {
  List<AppData> _items = [
    AppData(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    AppData(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    AppData(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    AppData(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
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
  void addProduct(AppData product) {
    final newProducts = AppData(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    // _items.add(newProducts);
    _items.insert(0, newProducts); //Adding it to the top of the products
    notifyListeners();
  }

  void updateProduct(String id, AppData newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
