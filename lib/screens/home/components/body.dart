import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/category_products.dart';
import '../../../size_config.dart';
import 'all_products.dart';

class Body extends StatelessWidget {
  Map data = {};
  String categorie;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    categorie = data != null ? data['categorie'] : null;
    Widget listProducts =
        categorie != null ? CategoryProducts(ctg: categorie) : AllProducts();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(40)),
            listProducts,
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
