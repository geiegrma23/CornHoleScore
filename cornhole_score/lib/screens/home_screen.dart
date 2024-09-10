import 'package:flutter/material.dart';
import 'quick_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool knockbackRule = false;

  void toggleKnockbackRule(bool value) {
    setState(() {
      knockbackRule = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backyard Scoring App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuickGameScreen(knockbackRule: knockbackRule),
                  ),
                );
              },
              child: const Text('Quick Game'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Knockback Rule'),
                Switch(
                  activeColor: Colors.black,        // The color of the switch thumb when ON
                  activeTrackColor: Colors.red,    // The color of the switch track when ON
                  inactiveThumbColor: Colors.white, // The color of the switch thumb when OFF
                  inactiveTrackColor: Colors.grey,  // The color of the switch track when OFF
                  value: knockbackRule,
                  onChanged: toggleKnockbackRule,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
