import 'package:flutter/material.dart';

class PresentationScreen extends StatelessWidget {
  static String routeName = "/presentation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/aggricus.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    "Aggricus is an online platform for the marketing of Tunisian agricultural, local and handicraft products, implemented within the framework of a cooperation agreement between the Technological Pole of Minoua and the Agriculture and Food Organization.",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  "4710-4890 Tunisia",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "contact@aggricus.com ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  " tel : 23 456 789 ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
