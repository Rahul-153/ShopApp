import 'package:flutter/material.dart';
import 'package:happy_shop/provider/products_provider.dart';
import 'package:happy_shop/screens/edit_products.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  UserProductItem({required this.id,required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context,listen: false).deleteProducts(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ))
          ],
        ),
      ),
    );
  }
}
