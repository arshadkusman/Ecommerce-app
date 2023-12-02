import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/login.dart';
import 'package:sample/provider/cart_provider.dart';



void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, 
    home: LoginPage());
  }
}
