import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/user.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/database.dart';
import '../../../components/size_config.dart';

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
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
    User user = FirebaseAuth.instance.currentUser;
    DatabaseService dbService = DatabaseService(uid: user.uid);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildFirstNameFormField(userData),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildLastNameFormField(userData),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(userData),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildAddressFormField(userData),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                FormError(errors: errors),
                DefaultButton(
                  text: "Continue",
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Map<String, Object> data = new HashMap();
                      if (email != null) data['email'] = email;
                      if (password != null) data['password'] = password;
                      if (firstName != null) data['firstName'] = firstName;
                      if (lastName != null) data['lastName'] = lastName;
                      if (phoneNumber != null)
                        data['phoneNumber'] = phoneNumber;
                      if (address != null) data['address'] = address;
                      print(data);
                      EasyLoading.show(status: 'Saving...');
                      dynamic result = await dbService.updateUserData(data);
                      EasyLoading.dismiss();
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  TextFormField buildPasswordFormField(UserData userData) {
    return TextFormField(
      initialValue: userData.password,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Change your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField(UserData userData) {
    return TextFormField(
      initialValue: userData.firstName,
      onSaved: (newValue) => firstName = newValue,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField(UserData userData) {
    return TextFormField(
      initialValue: userData.address,
      onSaved: (newValue) => address = newValue,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(UserData userData) {
    return TextFormField(
      initialValue: userData.phoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField(UserData userData) {
    return TextFormField(
      initialValue: userData.lastName,
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
