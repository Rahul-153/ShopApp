import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteOnly {
    return _items.where((pd) => pd.isFavourite).toList();
  }

  Product findByid(String id) {
    return _items.firstWhere((pd) => pd.id == id);
  }

  Future<void> updateProduct(String productId, Product newProduct) async {
    final productIdx = _items.indexWhere((pd) => pd.id == productId);
    if (productIdx >= 0) {
      final url =
          'https://shop-app-5dc52-default-rtdb.firebaseio.com/products/$productId.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imgUrl': newProduct.imgUrl,
            'price': newProduct.price,
            'isFavourite': newProduct.isFavourite
          }));
      _items[productIdx] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> fetchAndSetProduct() async {
    const url =
        'https://shop-app-5dc52-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> finalItems = [];
      extractedData.forEach((prodID, prodData) {
        finalItems.add(Product(
            id: prodID,
            description: prodData['description'],
            title: prodData['title'],
            imgUrl: prodData['imgUrl'],
            price: prodData['price'],
            isFavourite: prodData['isFavourite']));
        _items = finalItems;
        notifyListeners();
      });
    } catch (e) {
      throw (e);
    }
  }


  Future<void> addProduct(Product product) {
    final url = Uri.https(
        'shop-app-5dc52-default-rtdb.firebaseio.com', '/products.json');
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'id': product.id,
              'description': product.description,
              'imgUrl': product.imgUrl,
              'isFavourite': product.isFavourite,
              'price': product.price
            }))
        .then((response) {
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          title: product.title,
          imgUrl: product.imgUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://shop-app-5dc52-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIdx = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIdx];
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIdx, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the item');
    }
    existingProduct = null;
  }
}
