import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({Key? key, required this.child}) : super(key: key);  // Constructor with child widget

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),  // Background image
          fit: BoxFit.cover,  // Fit the image to cover the screen
        ),
      ),
      child: child,  // Render the child widget (your screen's content)
    );
  }
}