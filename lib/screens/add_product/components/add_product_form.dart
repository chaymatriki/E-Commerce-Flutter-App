import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/product_provider.dart';
import '../../../components/default_button.dart';
import '../../../size_config.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue;
  String productName;
  String productPrice;
  String productDesc;
  List<String> _categories = [
    'Santé et Beauté',
    'Produits animaliers',
    'Plantes aromatiques et médicinales',
    'Produits artisanaux',
    'Plats traditionnels'
  ];
  File _image;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildProductNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductDescriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductPriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _provider.getProductImage().then((image) {
                  setState(() {
                    _image = image;
                  });
                });
              },
              child: SizedBox(
                width: 150,
                height: 150,
                child: Card(
                  child: Center(
                    child: _image == null
                        ? Text('Select image')
                        : Image.file(_image),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductCategoryFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          DefaultButton(
            text: "Add product",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (_image != null) {
                  if (dropdownValue == null) {
                    addError(error: 'Select Category');
                  } else {
                    //upload image
                    EasyLoading.show(status: 'Saving...');
                    _provider.uploadImage(_image.path, productName).then((url) {
                      if (url != null) {
                        //upload to firestore
                        EasyLoading.dismiss();
                        _provider.saveProductToDB(productName, productPrice,
                            dropdownValue, productDesc);
                        //print('PRINT SUCCESS');
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        print('FAILED TO UPLOAD IMAGE');
                      }
                    });
                  }
                } else {
                  addError(error: 'Select Image');
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildProductNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => productName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter the product name");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter the product name");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Product Name",
        hintText: "Enter the product name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/product.svg"),
      ),
    );
  }

  TextFormField buildProductDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => productDesc = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter the product description");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter the product description");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Product Description",
        hintText: "Enter the product description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }

  TextFormField buildProductPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => productPrice = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Enter price');
          return value;
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Enter price');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Product Price",
        hintText: "Enter the product price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/money.svg"),
      ),
    );
  }

  Widget buildProductCategoryFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category : ',
            style: TextStyle(color: Colors.grey[800]),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            hint: Text('Select Category'),
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            onChanged: (String value) {
              setState(() {
                dropdownValue = value;
              });
            },
            items: _categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
