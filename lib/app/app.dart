import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
