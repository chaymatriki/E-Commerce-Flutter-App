import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/services/product_provider.dart';
import '../../../size_config.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List productsList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    List resultant = await ProductProvider().getAllProductsList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        productsList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Text(
              "Our Products",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[300]),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: 5.0),
            child: Wrap(
              children: [
                ...List.generate(
                  productsList.length,
                  (index) {
                    return ProductCard(product: productsList[index]);
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
