import 'package:flutter/material.dart';
import 'package:shop_app/screens/account_screen/account_screen.dart';
import 'package:shop_app/screens/add_product/add_product_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/auth.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user_image.png"),
            ),
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.popAndPushNamed(context, AccountScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Add Product",
            icon: "assets/icons/Shop Icon.svg",
            press: () {
              Navigator.popAndPushNamed(context, AddProductScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
