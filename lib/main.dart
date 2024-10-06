import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'currency_converter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginpage.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: CurrencyConverter(),

    );
  }
}

