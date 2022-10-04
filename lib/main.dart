import 'package:flutter/material.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      routes: Routes.routes,
      initialRoute: Routes.splashPageKey,
    );
  }
}
