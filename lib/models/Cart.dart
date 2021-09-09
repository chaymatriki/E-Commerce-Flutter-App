import 'package:flutter/material.dart';
import 'Product.dart';

class Cart {
  final Product product;

  Cart({@required this.product});
}

List<Cart> productsCarts = [];

void addProduct(Product product) {
  productsCarts.add(Cart(product: product));
}
