import 'package:flutter/material.dart';
import 'package:happy_shop/screens/edit_products.dart';
import '../widgets/app_drawer.dart';
import 'package:happy_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your Products"),
          actions: [IconButton(onPressed: () {
            Navigator.pushNamed(context, EditProductScreen.routeName);
          }, icon: const Icon(Icons.add))]),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            return Column(
              children: [
                UserProductItem(
                  id: productsData.items[idx].id,
                    title: productsData.items[idx].title,
                    imgUrl: productsData.items[idx].imgUrl),
                Divider()
              ],
            );
          },
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
