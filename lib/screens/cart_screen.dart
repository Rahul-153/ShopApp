import 'package:flutter/material.dart';
import 'package:happy_shop/provider/orders.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text('\$${cart.totalAmount}',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount,);
                        cart.clear();
                      },
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => ci.CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title),
            itemCount: cart.getItemCount,
          ))
        ],
      ),
    );
  }
}
