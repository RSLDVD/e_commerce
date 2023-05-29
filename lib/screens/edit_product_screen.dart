import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    image: '',
  );

  final _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'image': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProoduct(_editedProduct.id!, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  TextFormField _buildTitleTextField() {
    return TextFormField(
      initialValue: _initValues['title'],
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_priceFocusNode);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          title: value,
          price: _editedProduct.price,
          description: _editedProduct.description,
          image: _editedProduct.image,
          id: _editedProduct.id,
          isFavorite: _editedProduct.isFavorite,
        );
      },
    );
  }

  TextFormField _buildPriceTextField() {
    return TextFormField(
      initialValue: _initValues['price'],
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      focusNode: _priceFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_descriptionFocusNode);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          title: _editedProduct.title,
          price: double.parse(value!),
          description: _editedProduct.description,
          image: _editedProduct.image,
          id: _editedProduct.id,
          isFavorite: _editedProduct.isFavorite,
        );
      },
    );
  }

  TextFormField _buildDescriptionTextField() {
    return TextFormField(
      initialValue: _initValues['description'],
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      focusNode: _descriptionFocusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          title: _editedProduct.title,
          price: _editedProduct.price,
          description: value,
          image: _editedProduct.image,
          id: _editedProduct.id,
          isFavorite: _editedProduct.isFavorite,
        );
      },
    );
  }

  TextFormField _buildImageUrlTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) {
        _saveForm();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          title: _editedProduct.title,
          price: _editedProduct.price,
          description: _editedProduct.description,
          image: value!,
          id: _editedProduct.id,
          isFavorite: _editedProduct.isFavorite,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.8),
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.black, fontFamily: 'AlfaSlabOne'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              _buildTitleTextField(),
              _buildPriceTextField(),
              _buildDescriptionTextField(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.asset(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(child: _buildImageUrlTextField()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
