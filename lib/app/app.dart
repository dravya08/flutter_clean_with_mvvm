import 'package:flutter/material.dart';

import '../presentation/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
