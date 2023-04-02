import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../provider/product.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool _showFavorite;
  ProductGrid(this._showFavorite);
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final productData = _showFavorite?products.favouriteOnly: products.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, idx) {
        return ChangeNotifierProvider.value(
          value: productData[idx],
          child: ProductItem(),
        );
      },
      padding: EdgeInsets.all(10),
      itemCount: productData.length,
    );
  }
}
