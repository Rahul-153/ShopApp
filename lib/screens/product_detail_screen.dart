import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findByid(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 400,
                width: double.infinity,
                child: Image.network(loadedProduct.imgUrl,fit: BoxFit.cover,)),
                SizedBox(height: 10,),
                Text('\$${loadedProduct.price}',style: TextStyle(fontSize: 20,color: Colors.black45),),
                SizedBox(height: 10,),
                Text('${loadedProduct.description}',style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}
