import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  // Import your custom home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cornhole Score App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),  // Set the home screen as the initial screen
    );
  }
}
