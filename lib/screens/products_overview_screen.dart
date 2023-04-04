import 'package:flutter/material.dart';
import 'package:happy_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../widgets/product_grid.dart';
import '../provider/product.dart';
import '../provider/cart.dart';
import '../widgets/badge.dart';

enum filterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop",),
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                setState(() {
                  if (selectedValue == filterOptions.Favorites) {
                    _showFavorite = true;
                  } else {
                    _showFavorite = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Only Favorites"),
                      value: filterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: filterOptions.All,
                    ),
                  ]),
          Consumer<Cart>(
              builder: (_, cart, child) => BadgeWidget(
                value: cart.getItemCount.toString(),
                child: child!,
              ),
              child: IconButton(onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }, icon: Icon(Icons.shopping_cart)),
            ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showFavorite),
    );
  }
}
