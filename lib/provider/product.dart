import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.description,
    required this.title,
    required this.imgUrl,
    required this.price,
    this.isFavourite=false,
  });

  void toggleFavorite(){
    isFavourite=!isFavourite;
    notifyListeners();
  }
}