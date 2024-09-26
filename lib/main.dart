import 'package:flutter/material.dart';
import 'package:money_management/pages/category_page.dart';
import 'package:money_management/pages/home_page.dart';
import '../pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(primarySwatch: Colors.amber),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        CategoryPage.routeName: (ctx) => CategoryPage()
      },
    );
  }
}
