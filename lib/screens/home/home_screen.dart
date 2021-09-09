import 'package:flutter/material.dart';
import 'package:shop_app/components/main_drawer.dart';
import 'package:shop_app/screens/home/components/bottom_navbar.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
