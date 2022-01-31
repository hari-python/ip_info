import 'package:flutter/material.dart';
import 'home.dart';
import 'constants.dart' as val;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amber[50],
      ),
      home:  Home(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
