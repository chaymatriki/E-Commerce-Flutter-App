import 'package:flutter/material.dart';

class Product {
  final String id;
  final String image;
  final String title;
  final String price;
  final String category;
  final String description;

  Product({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.price,
    @required this.category,
    @required this.description,
  });
}
