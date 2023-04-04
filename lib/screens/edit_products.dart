import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName='/add-products';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode= FocusNode();
  final _descriptionFocusNode= FocusNode();
  @override
  void dispose() {
   _priceFocusNode.dispose();
   _descriptionFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(label: Text("Title")),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: Text("Price")),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              }
            ),
            TextFormField(
              decoration: InputDecoration(label: Text("Description")),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              focusNode: _descriptionFocusNode,
            ),
          ],
        )),
      ),
    );
  }
}
