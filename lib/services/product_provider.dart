import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/services/auth.dart';

class ProductProvider extends ChangeNotifier {
  File image;
  String pickerError = '';
  String productUrl;
  final AuthService _auth = AuthService();
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('products');

  //select image form
  Future<File> getProductImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      this.image = File(pickedFile.path);
      notifyListeners();
    } else {
      this.pickerError = 'No image selected';
      print('No image selected');
      notifyListeners();
    }
    return this.image;
  }

  //upload product image to firestore
  Future<String> uploadImage(filePath, productName) async {
    var timeStamp = Timestamp.now().millisecondsSinceEpoch;
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;

    try {
      await _storage
          .ref('/uploads/productImage/$productName/$timeStamp')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String downloadURL = await _storage
        .ref('/uploads/productImage/$productName/$timeStamp')
        .getDownloadURL();
    this.productUrl = downloadURL;
    notifyListeners();
    return downloadURL;
  }

  //save product to DB
  Future<void> saveProductToDB(String productName, String productPrice,
      String dropdownValue, String productDesc) async {
    User user = FirebaseAuth.instance.currentUser;
    var timeStamp = DateTime.now().microsecondsSinceEpoch; //product ID
    CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('products');

    try {
      await productsCollection.doc(timeStamp.toString()).set({
        'productID': timeStamp.toString(),
        'seller': user.uid,
        'price': productPrice,
        'productName': productName,
        'category': dropdownValue,
        'productImage': productUrl,
        'description': productDesc,
      });
      print('PRODUCT SAVED SUCCESSFULLY');
    } catch (e) {
      print('ERROR PRODUCT SAVING');
      print(e.toString());
      return null;
    }
  }

  Future getAllProductsList() async {
    List itemsList = [];

    try {
      await productsCollection.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(Product(
              id: element.data()['productID'],
              image: element.data()['productImage'],
              title: element.data()['productName'],
              price: element.data()['price'],
              description: element.data()['description'],
              category: element.data()['category']));
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsList(String ctg) async {
    List itemsList = [];

    try {
      await productsCollection
          .where('category', isEqualTo: ctg)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(Product(
              id: element.data()['productID'],
              image: element.data()['productImage'],
              title: element.data()['productName'],
              price: element.data()['price'],
              description: element.data()['description'],
              category: element.data()['category']));
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
