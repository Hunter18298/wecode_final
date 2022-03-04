import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/constants.dart';
import 'package:wecode_final/providers/app_brain.dart';
import 'package:wecode_final/providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit_product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageURlController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isInit = true;
  Map<String, String> _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  AppData _editProduct =
      AppData(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _editProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _initValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': _editProduct.imageUrl,
        };
        _imageURlController.text = _editProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageURlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageURlController.text.startsWith('http') &&
              !_imageURlController.text.startsWith('https')) ||
          (!_imageURlController.text.endsWith('.png') &&
              !_imageURlController.text.endsWith('.jpg') &&
              !_imageURlController.text.endsWith('.PNG') &&
              !_imageURlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Products"),
        actions: [
          IconButton(
            color: kWhite,
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onSaved: (value) {
                  _editProduct = AppData(
                    title: value!,
                    isFavourite: _editProduct.isFavourite,
                    id: _editProduct.id,
                    description: _editProduct.description,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter a Title";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                onSaved: (value) {
                  _editProduct = AppData(
                    title: _editProduct.title,
                    isFavourite: _editProduct.isFavourite,
                    id: _editProduct.id,
                    description: _editProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter a price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please Enter a Valid Number";
                  }
                  if (double.tryParse(value)! <= 0) {
                    return "Please Enter a Valid Number Greater Than 0";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                onSaved: (value) {
                  _editProduct = AppData(
                    title: _editProduct.title,
                    isFavourite: _editProduct.isFavourite,
                    id: _editProduct.id,
                    description: value!,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Descrip your Product";
                  }
                  if (value.length < 10) {
                    return "Please Enter a Description at least more than 10 characters";
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(width: 1.0),
                    ),
                    child: _imageURlController.text.isEmpty
                        ? const Text('Enter ImageUrl')
                        : FittedBox(
                            child: Image.network(
                              _imageURlController.text.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageUrlFocusNode,
                      controller: _imageURlController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: "Image Url",
                      ),
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editProduct = AppData(
                          title: _editProduct.title,
                          isFavourite: _editProduct.isFavourite,
                          id: _editProduct.id,
                          description: _editProduct.description,
                          price: _editProduct.price,
                          imageUrl: value!,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter an Image URL";
                        }
                        // if (!value.startsWith('http') ||
                        //     !value.startsWith('https')) {
                        //   return 'Please Enter a valid Image URL';
                        // }
                        // if (!value.endsWith('.png') ||
                        //     !value.endsWith('.jpg') ||
                        //     !value.endsWith('.PNG') ||
                        //     !value.endsWith('.jpeg')) {
                        //   return 'Please Enter a valid Image URL Format';
                        // }
                        // return null;
                        _updateImageUrl();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
