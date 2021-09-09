import 'package:flutter/material.dart';
import 'package:shop_app/screens/wrapper.dart';
import 'package:shop_app/services/auth.dart';
import 'models/user.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/product_provider.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (_) => ProductProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aggricus shop',
        theme: theme(),
        builder: EasyLoading.init(),
        initialRoute: Wrapper.routeName,
        routes: routes,
      ),
    );
  }
}
