import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('Hello Friends'),
          automaticallyImplyLeading: false,),
          const Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: (){
              Navigator.pushReplacementNamed(context,'/');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: (){
              Navigator.pushNamed(context,OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: (){
              Navigator.pushNamed(context,UserProductScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}