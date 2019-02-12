import 'package:demo_flutter_inventory_app/src/ui/home_page.dart';
import 'package:demo_flutter_inventory_app/src/ui/styles/themes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme(),
      home: HomePage(),
    );
  }
}
