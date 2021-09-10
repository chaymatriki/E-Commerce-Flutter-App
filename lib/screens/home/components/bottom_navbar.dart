import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/about_us.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset("assets/icons/Shop Icon.svg",
                    color: Color(0xFFB6B6B6)),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Cart Icon.svg",
                      color: Color(0xFFB6B6B6)),
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  }),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Call.svg",
                      color: Color(0xFFB6B6B6)),
                  onPressed: () {
                    Navigator.pushNamed(context, PresentationScreen.routeName);
                  }),
              IconButton(
                icon: SvgPicture.asset("assets/icons/User Icon.svg",
                    color: Color(0xFFB6B6B6)),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
