import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'jewelry',
      description: textData,
      price: 29.99,
      image: 'assets/images/ring.png',
    ),
    Product(
      id: 'p2',
      title: 'Black',
      description: textData,
      price: 999.99,
      image: 'assets/images/bag_6.png',
    ),
    Product(
      id: 'p3',
      title: 'shoes',
      description: textData,
      price: 59.99,
      image: 'assets/images/shoe.png',
    ),
    Product(
      id: 'p4',
      title: 'Bag 3',
      description: textData,
      price: 19.99,
      image: 'assets/images/bag_5.png',
    ),
    
  ];
  //

  List<Product> get items {
    return [..._items];
  }

  //
  List<Product> get favoriteItems {
    return items.where((x) => x.isFavorite).toList();
  }
  //

  void addProduct(Product p) {
    final newProduct = Product(
        id: DateTime.now().toIso8601String(),
        title: p.title,
        description: p.description,
        price: p.price,
        image: p.image);
    _items.add(newProduct);
    notifyListeners();
  }

  //
  void updateProoduct(String id, Product editedProduct) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index] = editedProduct;
      notifyListeners();
    } else {}
  }

  //
  void deleteProduct(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  //

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  //
  static const textData =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
}
