import 'package:flutter/material.dart';
import 'package:happy_shop/provider/products_provider.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = '/add-products';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading=false;
  var _editedProduct =
      Product(id: '', description: '', title: '', imgUrl: '', price: 0);
  var initValues = {'title': '', 'description': '', 'price': '', 'imgUrl': ''};
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByid(productId.toString());
        initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imgUrl': ''
        };
        _imageUrlController.text=_editedProduct.imgUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    setState(() {
      _isLoading=true;
    });
    if(_editedProduct.id==''){
Provider.of<Products>(context, listen: false).addProduct(_editedProduct).then((_){
  setState(() {
    _isLoading=false;
  });
  Navigator.of(context).pop();
});
    }
    else{
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id,_editedProduct);
      setState(() {
    _isLoading=false;
  });
      Navigator.of(context).pop();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading? const Center(child: CircularProgressIndicator(),): Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: initValues['title'],
                  decoration: const InputDecoration(label: Text("Title")),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      isFavourite: _editedProduct.isFavourite,
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        title: value!,
                        imgUrl: _editedProduct.imgUrl,
                        price: _editedProduct.price);
                  },
                ),
                TextFormField(
                  initialValue: initValues['price'],
                  decoration: const InputDecoration(label: Text("Price")),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a text';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.tryParse(value)! <= 0) {
                      return 'Please enter a number greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      isFavourite: _editedProduct.isFavourite,
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        title: _editedProduct.title,
                        imgUrl: _editedProduct.imgUrl,
                        price: double.parse(value!));
                  },
                ),
                TextFormField(
                  initialValue: initValues['description'],
                    decoration:
                        const InputDecoration(label: Text("Description")),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    focusNode: _descriptionFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      if (value.length < 10) {
                        return 'Please enter description atleast 10 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        isFavourite: _editedProduct.isFavourite,
                          id: _editedProduct.id,
                          description: value!,
                          title: _editedProduct.title,
                          imgUrl: _editedProduct.imgUrl,
                          price: _editedProduct.price);
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(right: 10, top: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? const Text("Enter Url")
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Image Url")),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              isFavourite: _editedProduct.isFavourite,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                title: _editedProduct.title,
                                imgUrl: value!,
                                price: _editedProduct.price);
                          }),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
