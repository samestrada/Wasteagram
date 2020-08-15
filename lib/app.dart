import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/photo_screen.dart';


class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName : (context) => ListScreen(),
    DetailScreen.routeName : (context) => DetailScreen(),
    PhotoScreen.routeName : (context) => PhotoScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      routes: routes,
      theme: ThemeData.dark(),
    );
  }
}