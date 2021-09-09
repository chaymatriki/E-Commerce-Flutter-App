import 'package:flutter/material.dart';
import 'package:shop_app/models/user.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'splash/splash_screen.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/wrapper";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return SplashScreen();
    } else {
      return HomeScreen();
    }
  }
}
