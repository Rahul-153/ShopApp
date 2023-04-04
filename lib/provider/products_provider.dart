import 'dart:convert';
import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteOnly {
    return _items.where((pd) => pd.isFavourite).toList();
  }

  Product findByid(String id) {
    return _items.firstWhere((pd) => pd.id == id);
  }
  void updateProduct(String productId,Product newProduct){
    final productIdx=_items.indexWhere((pd) => pd.id==productId);
    if(productIdx>=0){_items[productIdx]=newProduct;
    notifyListeners();}else{
      print('...');
    }
  }
  Future<void> addProduct(Product product) {
    final url = Uri.https('shop-app-5dc52-default-rtdb.firebaseio.com','/products.json');
    return http.post(url,body: json.encode({
      'title':product.title,
      'id':product.id,
      'description':product.description,
      'imgUrl':product.imgUrl,
      'isFavourite':product.isFavourite,
      'price':product.price
    })).then((response){
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        title: product.title,
        imgUrl: product.imgUrl,
        price: product.price);
    _items.add(newProduct);
    notifyListeners();
    } );
  }
  void deleteProducts(String id){
    _items.removeWhere((prod) => prod.id==id);
    notifyListeners();
  }
}
