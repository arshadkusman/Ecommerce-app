import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/login.dart';
import 'package:sample/provider/cart_provider.dart';



void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, 
    home: LoginPage());
  }
}
